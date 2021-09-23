
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState>? navKey;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navKey = GlobalKey<NavigatorState>();
  }

  Future<dynamic> navigateToReplacement(String _name) async {
    return navKey!.currentState!.pushReplacementNamed(_name);
  }



  Future<dynamic> navigateTo(String _name) async {
    return navKey!.currentState!.pushNamed(_name);
  }



  Future<dynamic> navigateToRoute(MaterialPageRoute _route) async {
    return navKey!.currentState!.push(_route);
  }


  void goBack() {
    return navKey!.currentState!.pop();
  }
}