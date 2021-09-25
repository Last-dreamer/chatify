

import 'package:chatify/services/navigation_services.dart';
import 'package:chatify/services/snackbar_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error
}


class AuthProvider extends ChangeNotifier {

  UserCredential? user;
  AuthStatus? status;
  late FirebaseAuth _auth;
  static AuthProvider instance = AuthProvider();

  AuthProvider() {
    _auth = FirebaseAuth.instance;
  }

  void loginUserWithEmailAndPassword(String _email, String _password) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try{
     UserCredential _result = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
     user = _result;
     status = AuthStatus.Authenticated;
     SnackBarService.instance.showSnackBarSuccess("Welcome, ${user!.user!.email}");
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
      UserCredential auth = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
      user = auth;
      await onSuccess(user!.user!.uid);
      SnackBarService.instance.showSnackBarSuccess(" ${user!.user!.email} is registered successfully");
      NavigationService.instance.goBack();
      NavigationService.instance.navigateToReplacement('home');
      status = AuthStatus.Authenticated;
    }catch(e){
      status = AuthStatus.Error;
      user = null;
      print(e);
      SnackBarService.instance.showSnackBarError("Error while authenticating");
    }
    notifyListeners();
  }
}
