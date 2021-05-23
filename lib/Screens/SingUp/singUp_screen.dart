import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sezapp/Screens/Login/usersAction.dart';
import 'package:sezapp/api/user_api_service.dart';
import 'package:sezapp/conponents/buttonFull.dart';
import 'package:sezapp/conponents/inputField.dart';
import 'package:sezapp/model/register_model.dart';

import '../../constants.dart';

class SingUpScreen extends StatefulWidget {
  @override
  _SingUpScreenState createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  RegisterRequestModel registerRequestModel = new RegisterRequestModel();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>(); //form key

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final ageController = TextEditingController();
  String sexDropdownValue = 'Masculine';
  String roleDropdownValue = "Patient";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      color: kLightColor,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children:
        <Widget>[
          Form(
            key: globalFormKey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              child: Column(
                children: <Widget>[
                  Container(
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: kPrimaryColor,
                      ),
                    ),
                  )),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  InputFiled(
                    hintText: "FirstName",
                    validator: emptyValidator,
                    obscuredText: false,
                    controller: firstNameController,
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  InputFiled(
                    hintText: "Last Name",
                    validator: emptyValidator,
                    obscuredText: false,
                    controller: lastNameController,
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  InputFiled(
                    hintText: "Email",
                    validator: emptyValidator,
                    obscuredText: false,
                    controller: emailController,
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  InputFiled(
                    hintText: "Password",
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'cannot be empty';
                      } else {
                        if (value != confirmPasswordController.text)
                          return 'password dos not match';
                      }

                      return null;
                    },
                    obscuredText: true,
                    controller: passwordController,
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  InputFiled(
                    hintText: "Confirm password",
                    validator: emptyValidator,
                    obscuredText: true,
                    controller: confirmPasswordController,
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  InputFiled(
                    validator: emptyValidator,
                    hintText: "Age ex: 25",
                    obscuredText: false,
                    controller: ageController,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Sex"),
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(143, 148, 251, 0.2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 15))
                                  ]),
                              width: size.width * 0.4,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: DropdownButton(
                                      isExpanded: true,
                                      value: sexDropdownValue,
                                      underline: SizedBox(),
                                      items: ['Masculine', 'Feminine']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                            value: value, child: Text(value));
                                      }).toList(),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          sexDropdownValue = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(7.0),
                              child: Text(
                                "I am a: ",
                                style: TextStyle(),
                              ),
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(143, 148, 251, 0.2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 15))
                                  ]),
                              width: size.width * 0.4,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: DropdownButton(
                                      isExpanded: true,
                                      value: roleDropdownValue,
                                      underline: SizedBox(),
                                      items: ['Patient', 'Doctor']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                            value: value, child: Text(value));
                                      }).toList(),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          roleDropdownValue = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  ButtonFull(
                    width: 320,
                    height: 60,
                    name: "Register",
                    callback: _registerSubmit,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Do you have an Account?  ",
                        style: TextStyle(color: kPrimaryColor, fontSize: 16),
                      ),
                      GestureDetector(
                        child: Text(
                          "Log in",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', ModalRoute.withName('/login'));
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    ));
  }

  Function emptyValidator = (value) {
    if (value.isEmpty) {
      return 'cannot be empty';
    }

    return null;
  };

  void _registerSubmit() async {
    if (!globalFormKey.currentState.validate()) {
      print("asd");
      setState(() {
        Flushbar(
          title: "Complette all fields",
          message: "Please fix the errors in red before submitting.",
          duration: Duration(seconds: 5),
        ).show(context);
      });
    } else {
      registerRequestModel.firstName = firstNameController.text;
      registerRequestModel.lastName = lastNameController.text;
      registerRequestModel.email = emailController.text;
      registerRequestModel.password = passwordController.text;
      registerRequestModel.age = int.parse(ageController.text);
      if (sexDropdownValue == "Masculine") {
        registerRequestModel.sex = 'M';
      } else {
        registerRequestModel.sex = 'F';
      }
      if (roleDropdownValue == "Patient") {
        registerRequestModel.role = "patient";
      } else {
        registerRequestModel.role = "doctor";
      }

      var response = await registerUser(registerRequestModel);
      print(response);

      if (response["id"] == null) {
        setState(() {
          Flushbar(
            title: "Error",
            messageText: Text(
              response['message'],
              style: TextStyle(color: Colors.red),
            ),
            backgroundColor: kPrimaryColor,
            duration: Duration(seconds: 5),
          ).show(context);
        });
      } else
        saveAndRedirectToHome(response, context);
    }
  }
}
