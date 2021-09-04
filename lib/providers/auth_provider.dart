

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
     print('Login Successfully ...');
    }catch (e){
      status =  AuthStatus.Error;
      print('Login Error.....');
    }
    notifyListeners();
  }

}
