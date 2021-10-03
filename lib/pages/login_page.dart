import 'package:chatify/pages/registeration_page.dart';
import 'package:chatify/providers/auth_provider.dart';
import 'package:chatify/services/navigation_services.dart';
import 'package:chatify/services/snackbar_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  late double _deviceHeight;
  late double _deviceWidth;

  GlobalKey<FormState>? _formKey;

  _LogInState() {
    _formKey = GlobalKey<FormState>();
  }

  String? _email;
  String? _password;

  AuthProvider? _auth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Align(
          alignment: Alignment.center,
          child: ChangeNotifierProvider.value(
              value: AuthProvider.instance,
            child: _loginPageUI(),
          ),
        ));
  }

  Widget _loginPageUI() {
    return Builder(builder: (BuildContext _context) {
      SnackBarService.instance.buildContext = _context;
      _auth = Provider.of<AuthProvider>(_context);
      print(_auth!.user);
      return Container(
        height: _deviceHeight * 0.60,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerWidget(),
            _inputForm(),
            _loginButton(),
            _registerButton(),
          ],
        ),
      );
    },);
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
            'Welcome Back',
            style: TextStyle(
                fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          Text(
            'please login to your account',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }


  Widget _inputForm() {
    return Container(
      height: _deviceHeight * 0.18,
      child: Form(
        key: _formKey,
        onChanged: (){
          setState(() {
            _formKey!.currentState!.save();
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _emailTextField(),
            _passwordTextField(),
          ],
        ),
      ),
    );
  }


  Widget _emailTextField() {
    return TextFormField(
      autocorrect: false,
      style: TextStyle(color: Colors.white),
      onSaved: (_input){
        _email = _input;
      },
      validator: (value) {
        return value!.length != 0  &&  value.contains("@") ? null : 'please enter a valid email';
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: 'Email',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
        )
      ),

    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      style: TextStyle(color: Colors.white),
      onSaved: (_input){
        _password = _input;
      },
      validator: (_input) {
        return _input!.length != 0 ? null : 'please enter a password!';
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
          hintText: 'Password',
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
          )
      ),
    );
  }

  Widget _loginButton(){
    return _auth!.status == AuthStatus.Authenticating ?
    Align(alignment: Alignment.center, child: CircularProgressIndicator(),):
    Container(
      height: _deviceHeight * 0.06,
      width: _deviceWidth,
      child: MaterialButton(
         shape: StadiumBorder(),
        color: Colors.blue,
        onPressed: (){
          if(_formKey!.currentState!.validate()){
          _auth!.loginUserWithEmailAndPassword(_email!, _password!);
          }
        },
        child: Text('LOGIN', style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700
        ),),
      ),
    );
  }


  Widget _registerButton(){
    return GestureDetector(
      onTap: (){
       NavigationService.instance.navigateTo('register');
      },
      child: Container(
        height: _deviceHeight * 0.06,
        width: _deviceWidth,
        alignment: Alignment.center,
        child: Text('REGISTER', style: TextStyle(
            color: Colors.white60,
            fontSize: 18,
            fontWeight: FontWeight.w700
        ),),
      ),
    );
  }
}



