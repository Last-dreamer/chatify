import 'dart:io';

import 'package:chatify/pages/login_page.dart';
import 'package:chatify/services/media_services.dart';
import 'package:chatify/services/navigation_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterationPage extends StatefulWidget {
  const RegisterationPage({Key? key}) : super(key: key);

  @override
  _RegisterationPageState createState() => _RegisterationPageState();
}

class _RegisterationPageState extends State<RegisterationPage> {
  late double _deviceWidth;
  late double _deviceHeight;
  File? _image;

  late GlobalKey<FormState> _formState;

  _RegisterationPageState() {
    _formState = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: signupPageUI(),
      ),
    );
  }

  Widget signupPageUI() {
    return Container(
      width: _deviceWidth * 0.85,
      height: _deviceHeight * 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _headerWidget(),
          _inputForm(),
          _loginButton(),
          _registerButton()
        ],
      ),
    );
  }

  Widget _headerWidget() {
    return Container(
      height: _deviceHeight * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Let\'s get Going! ',
            style: TextStyle(
                fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          Text(
            'please enter your detail...',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputForm() {
    return Container(
      height: _deviceHeight * 0.35,
      child: Form(
        key: _formState,
        onChanged: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            _imageSelectionWidget(),
            _nameTextField(),
            _emailTextField(),
            _passwordTextField(),
          ],
        ),
      ),
    );
  }

  Widget _imageSelectionWidget() {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () async {
          final f = await MediaServices.instance.getImageFromLibrary();
          setState(() {
            _image = File(f!.path);
          });
        },
        child: Container(
          height: _deviceHeight * 0.10,
          width: _deviceWidth * 0.17,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(500),
            // image:
            // DecorationImage(
            //   fit: BoxFit.cover,
            //   image:_image != null ?
            //   '' :
            //   NetworkImage("https://cdn0.iconfinder.com/data/icons/occupation-002/64/programmer-programming-occupation-avatar-512.png"),
            // ),
          ),
          child: _image != null
              ? ClipOval(
               child: Image.file(
                 _image!,
                 fit: BoxFit.cover,

               ),
          )
              : Image.network(
                  "https://cdn0.iconfinder.com/data/icons/occupation-002/64/programmer-programming-occupation-avatar-512.png"),
        ),
      ),
    );
  }

  Widget _nameTextField() {
    return TextFormField(
      autocorrect: false,
      style: TextStyle(color: Colors.white),
      onSaved: (_input) {},
      validator: (value) {
        return value!.length != 0 ? null : 'please enter a Name';
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
          hintText: 'Name',
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      autocorrect: false,
      style: TextStyle(color: Colors.white),
      onSaved: (_input) {},
      validator: (value) {
        return value!.length != 0 && value.contains("@")
            ? null
            : 'please enter a valid email';
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
          hintText: 'Email',
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      style: TextStyle(color: Colors.white),
      onSaved: (_input) {},
      validator: (_input) {
        return _input!.length != 0 ? null : 'please enter a password!';
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
          hintText: 'Password',
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
    );
  }

  Widget _loginButton() {
    return Container(
      height: _deviceHeight * 0.06,
      width: _deviceWidth,
      child: MaterialButton(
        color: Colors.blue,
        onPressed: () {},
        child: Text(
          'REGISTER',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return GestureDetector(
      onTap: () {
        NavigationService.instance.goBack();
      },
      child: Container(
        width: _deviceWidth,
        height: _deviceHeight * 0.06,
        child: Icon(Icons.arrow_back, size: 35, color: Colors.white),
      ),
    );
  }
}
