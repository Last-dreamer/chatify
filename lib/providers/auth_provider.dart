

import 'package:chatify/services/navigation_services.dart';
import 'package:chatify/services/snackbar_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error
}


class AuthProvider extends ChangeNotifier {

  User? user;
  AuthStatus? status;
  late FirebaseAuth _auth;
  static AuthProvider instance = AuthProvider();


  AuthProvider() {
    _auth = FirebaseAuth.instance;

    _checkUserIsAuthenticated();
  }

  void _autoLogin(){
    if(user != null){
      NavigationService.instance.navigateToReplacement("home");
    }
  }

  void _checkUserIsAuthenticated() async{
    user =  await _auth.currentUser!;
    if(user!=null){
      notifyListeners();
      _autoLogin();
    }

  }

  void loginUserWithEmailAndPassword(String _email, String _password) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try{
     final _result = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
     user = _result.user;
     status = AuthStatus.Authenticated;
     SnackBarService.instance.showSnackBarSuccess("Welcome, ${user!.displayName}");
     NavigationService.instance.navigateToReplacement('home');
    }catch (e){
      status =  AuthStatus.Error;
      user=null;
      SnackBarService.instance.showSnackBarError("Error while Authemticating...");
    }
    notifyListeners();
  }


  void registerWithEmailAndPassword(String _email, String _password,  Future<void> onSuccess(String _uid)) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try{
      final auth = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
      user = auth.user;
      await onSuccess(user!.uid);
      SnackBarService.instance.showSnackBarSuccess(" ${user!.email} is registered successfully");
      NavigationService.instance.goBack();
      NavigationService.instance.navigateTo("login");
      status = AuthStatus.Authenticated;
    }catch(e){
      status = AuthStatus.Error;
      user = null;
      print(e);
      SnackBarService.instance.showSnackBarError("Error while authenticating");
    }
    notifyListeners();
  }


  void logOutUser() async {
    try{
      await _auth.signOut();
      user = null;
      status = AuthStatus.NotAuthenticated;
      await NavigationService.instance.navigateToReplacement("login");
      SnackBarService.instance.showSnackBarSuccess("Logged Out Success");

    }catch(e) {
      SnackBarService.instance.showSnackBarError("error while logout");
    }
    notifyListeners();
  }



}
