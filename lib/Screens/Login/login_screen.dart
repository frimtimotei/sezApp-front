import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sezapp/Screens/Login/usersAction.dart';
import 'package:sezapp/api/user_api_service.dart';
import 'package:sezapp/conponents/loading.dart';
import 'package:sezapp/constants.dart';

import 'package:sezapp/model/login_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LoginRequestModel loginrequestmodel = new LoginRequestModel();
  bool _hidePassword = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return loading
        ? Loading()
        : Scaffold(
            key: scaffoldKey,
            body: Container(
              height: size.height,
              color: kLightColor,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Image.asset('assets/images/SezApp2.png',height: 80,),
                    // SizedBox(
                    //   height: size.height * 0.03,
                    // ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 70),
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/Untitled-2.png'),
                      )),
                    ),

                    Form(
                      key: globalFormKey,
                      child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                                child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: kPrimaryColor,
                                ),
                              ),
                            )),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(143, 148, 251, 0.2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[100]))),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                      controller: emailController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Email cannot be empty";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[100]))),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400]),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _hidePassword = !_hidePassword;
                                            });
                                          },
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.4),
                                          icon: Icon(_hidePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                        ),
                                      ),
                                      obscureText: _hidePassword,
                                      controller: passwordController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Password cannot be empty";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            Container(
                              height: 60.0,
                              width: size.width * 0.8,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                onPressed: () async {
                                  _loginSubmit();
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromRGBO(143, 148, 251, 1.0),
                                          Color.fromRGBO(143, 148, 251, 0.6)
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Login",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Don't have an Acount?  ",
                                  style: TextStyle(
                                      color: kPrimaryColor, fontSize: 17),
                                ),
                                GestureDetector(
                                  child: Text(
                                    "Sing up",
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/singUp',
                                        ModalRoute.withName('/singUp'));
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  void _loginSubmit() async {
    if (!globalFormKey.currentState.validate()) {
      setState(() {
        Flushbar(
          title: "Complete all fields",
          message: "Please fix the errors in red before submitting.",
          duration: Duration(seconds: 5),
        ).show(context);
      });
    } else {
      loading = true;
      loginrequestmodel.emil = emailController.text;
      loginrequestmodel.password = passwordController.text;

      var response = await loginUser(loginrequestmodel);
      print(response);

      if (response["id"] == null) {
        setState(() {
          loading = false;
          Flushbar(
            title: "Error",
            messageText: Text(
              response['message'],
              style: TextStyle(color: Colors.red),
            ),
            backgroundColor: kLightColor,
            duration: Duration(seconds: 5),
          ).show(context);
        });
      } else
        saveAndRedirectToHome(response, context);
    }
  }
}
