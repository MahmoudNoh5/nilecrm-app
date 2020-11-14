import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nilecrm/models/user.dart';
import '../utilities/constants.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// Create post request for creating user
Future<User> createUser(String email, String password) async {
  final String apiUrl = "http://test.nilecrm.com/api/v1/auth/login";

  // Setup the response
  final http.Response response = await http.post(apiUrl,
    /*  headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },*/
      headers: {"content-type": "application/json"},
      body: jsonEncode(<String, String>{
        "email": email,
        "password": password,
      }));

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return loginUser(responseString, email, password);
  } else {
    return null;
  }
}

class _LoginScreenState extends State<LoginScreen> {
  User _user;
  // Controller for user inputs
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Email field
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Color(0xFF404040),
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

//  // Password field
  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xFF404040),
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  // Login Button
  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          final String email = emailController.text;
          final String password = passwordController.text;

          final User user = await createUser(email, password);
          setState(() {
            _user = user;
          });
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xFF404040),
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFFffffff),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
//
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  /*padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),*/
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(image: AssetImage('assets/images/logo3.jpg')),

                      Container(
                        color: Color(0xFF3c8dbc),

                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 30.0,
                          ),
                          child: Column(
                            children: [
                              _buildEmailTF(),
                              SizedBox( height: 30,),
                              _buildPasswordTF(),
                              _buildLoginBtn(),

                              _user == null
                                  ? Container(
                                child: Text(' request is not completed'),
                              )
                                  : Text(
                                  "The user ${_user.email} is created successfully  "),    //${_user.createdAt.toIso8601String()}
                            ],

                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
