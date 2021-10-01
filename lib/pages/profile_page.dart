import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  double _height;
  double _width;

  ProfilePage(this._height, this._width);

  @override
  Widget build(BuildContext context) {
    return Center(child: _profilePageUI());
  }

  Widget _profilePageUI() {
    return Align(
      child: SizedBox(
        height: _height * .50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             _userImageWidget( "https://cdn0.iconfinder.com/data/icons/occupation-002/64/programmer-programming-occupation-avatar-512.png"),
            _userNameWidget("Dreamer"),
            _userEmailWidget("dreamer@gmail.com"),
            _userLogOutWidget()
          ],
        ),
      ),
    );
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
      child: MaterialButton(onPressed: (){},
        color: Colors.red,
        child: Text("LogOut", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700 ),),),
    );
  }



}
