import 'package:chatify/models/contact.dart';
import 'package:chatify/providers/auth_provider.dart';
import 'package:chatify/services/DBService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  double _height;
  double _width;

  AuthProvider? _auth;
  ProfilePage(this._height, this._width);

  String? name;
  String? image;
  String? email;

  Future getData(String uid) async{
    var data = await FirebaseFirestore.instance.collection("Users").doc(uid).get().then((v){
      print("some datas ${v.get("email")}");
      name= v.get('name');
      email = v.get('email');
      image = v.get("image");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: Center(child: _profilePageUI()));
  }

  Widget _profilePageUI() {
    return Builder(builder: (context) {
      _auth = Provider.of<AuthProvider>(context);
      return FutureBuilder(
        future: getData(_auth!.user!.uid),
        builder: (context, _snapshot){
           print("stream ${_snapshot.hasData}");
          return Align(
            child: SizedBox(
              height: _height * .50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _userImageWidget(image ?? "https://cdn0.iconfinder.com/data/icons/occupation-002/64/programmer-programming-occupation-avatar-512.png"),
                  _userNameWidget(name!),
                  _userEmailWidget(email!),
                  _userLogOutWidget()
                ],
              ),
            ),
          );
        },
      );
    },);
  }

  Widget _userImageWidget(String image) {
    double rad = _height * 0.20;
    return Container(
      width: rad,
      height: rad,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(rad),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(image)
        )
      ),
    );
  }

  Widget _userNameWidget(String name) {
    return Container(
      width: _width,
      height: _height * 0.05,
      child: Text(name, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 25),),
    );
  }

  Widget _userEmailWidget(String name) {
    return Container(
      width: _width,
      height: _height * 0.05,
      child: Text(name, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 25),),
    );
  }

  Widget _userLogOutWidget() {

    return Container(
      width: _width * .80,
      height: _height * .08,
      child: MaterialButton(onPressed: () async {

        _auth!.logOutUser();
      },
        color: Colors.red,
        child: Text("LogOut", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700 ),),),
    );
  }
}
