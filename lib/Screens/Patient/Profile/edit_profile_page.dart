import 'dart:convert';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sezapp/Screens/Patient/Add/addMedication.dart';
import 'package:sezapp/Screens/Patient/Profile/patientUser_page.dart';
import 'package:sezapp/Screens/Patient/Profile/profile_widget.dart';
import 'package:sezapp/api/user_api_service.dart';
import 'package:sezapp/conponents/appBar.dart';
import 'package:sezapp/conponents/buttonFull.dart';
import 'package:sezapp/conponents/inputField.dart';
import 'package:sezapp/constants.dart';
import 'package:sezapp/model/User.dart';
import 'package:path/path.dart';

class EditProfile extends StatefulWidget {
  final User currentUser;

  const EditProfile({Key key, this.currentUser}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>(); //form key
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firstNameController =
        TextEditingController(text: widget.currentUser.firstName);
    final lastNameController =
        TextEditingController(text: widget.currentUser.lastName);
    final emailController =
        TextEditingController(text: widget.currentUser.email);
    final ageController = TextEditingController(text: widget.currentUser.age);

    String imagePath = widget.currentUser.imageUrl;
    return Scaffold(
      backgroundColor: kLightColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: CustomAAppBar(
          title: "Edit Profile",
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Stack(
              children: <Widget>[
                ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: Ink.image(
                      image: checkImagePath(imagePath),
                      height: 118,
                      width: 118,
                      fit: BoxFit.cover,
                      child: InkWell(
                        onTap: () async {
                          final picker = ImagePicker();
                          final image = await picker.getImage(
                              source: ImageSource.gallery);
                          if (image == null) return;
                          final directory =
                              await getApplicationDocumentsDirectory();
                          final name = basename(image.path);
                          final imageFile = File('${directory.path}/$name');
                          final newImage =
                              await File(image.path).copy(imageFile.path);

                          setState(() {
                            widget.currentUser.imageUrl = newImage.path;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: ClipOval(
                    child: Container(
                      padding: EdgeInsets.all(3),
                      color: kLightColor,
                      child: ClipOval(
                        child: Container(
                            padding: EdgeInsets.all(8),
                            color: kPrimaryLightColor,
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 20,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Form(
            key: globalFormKey,
            child: Column(
              children: <Widget>[
                InputUserEdit(
                  controller: firstNameController,
                  title: "First Name:",
                  validator: emptyValidator,
                ),
                const SizedBox(
                  height: 10,
                ),
                InputUserEdit(
                  controller: lastNameController,
                  title: "Last Name:",
                  validator: emptyValidator,
                ),
                const SizedBox(
                  height: 10,
                ),
                InputUserEdit(
                  controller: emailController,
                  title: "Email:",
                  validator: emptyValidator,
                ),
                const SizedBox(
                  height: 10,
                ),
                InputUserEdit(
                  controller: ageController,
                  title: "Age:",
                  validator: emptyValidator,
                ),
                const SizedBox(
                  height: 30,
                ),
                ButtonFull(
                    name: "Update",
                    callback: () {
                      setState(() {
                        widget.currentUser.firstName = firstNameController.text;
                        widget.currentUser.lastName = lastNameController.text;
                        widget.currentUser.email = emailController.text;
                        widget.currentUser.age = ageController.text;
                      });
                      return updateProfile(widget.currentUser, context);
                    },
                    width: 200,
                    height: 50)
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateProfile(User currentUser, BuildContext context) async {
    if (globalFormKey.currentState.validate()) {
      if (!currentUser.imageUrl.contains('https://')) {
        var updatedImage = apiUploadUserPicture(currentUser.imageUrl);
        print(updatedImage.toString());
      }
      var response = await apiUpdateUserInfo(currentUser);
      if (response['id'] != null) {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            confirmBtnColor: kPrimaryColor,
            text: "Your data has been updated!",
            backgroundColor: kPrimaryColor,
            onConfirmBtnTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            });
      } else {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            confirmBtnColor: kPrimaryColor,
            text: "Error can not update data!",
            backgroundColor: kPrimaryColor,
            onConfirmBtnTap: () {
              Navigator.pop(context);
            });
      }
    }
  }

  Function emptyValidator = (value) {
    if (value.isEmpty) {
      return 'cannot be empty';
    }

    return null;
  };

  checkImagePath(String imagePath) {
    if(imagePath==null)
      return NetworkImage("https://sezapp-images.s3.eu-central-1.amazonaws.com/profilePicture.jpg");
    else return imagePath.contains('https://')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));
  }
}

class InputUserEdit extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Function validator;

  const InputUserEdit({
    Key key,
    @required this.title,
    @required this.controller,
    @required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(2.0),
            child: Text(
              title,
              style: TextStyle(color: kPrimaryColor, fontSize: 14),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.4, horizontal: 2),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(143, 148, 251, 0.1),
                      blurRadius: 20.0,
                      offset: Offset(0, 10))
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                controller: controller,
                validator: validator,
              ),
            ),
          )
        ],
      ),
    );
  }
}
