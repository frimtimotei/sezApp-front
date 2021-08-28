import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sezapp/screens/chat/messageRoom.dart';
import 'package:sezapp/api/user_api_service.dart';
import 'package:sezapp/constants.dart';
import 'package:sezapp/model/user/User.dart';
import 'package:sezapp/model/user/UserChatContactDTO.dart';

class ListAllUsersPage extends StatefulWidget {
  const ListAllUsersPage({Key key}) : super(key: key);

  @override
  _ListAllUsersPageState createState() => _ListAllUsersPageState();
}

class _ListAllUsersPageState extends State<ListAllUsersPage> {
  String searchString = '';
  final searchController = TextEditingController();
  User activeUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<User> _loadUserInfo() async {
    var response = await userInfo();

    if (response.statusCode == 200) {
      response = jsonDecode(response.body);
    }
    return User.fromJson(response);
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLightColor,
      child: Column(
        children: [
          buildSearch(),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: FutureBuilder(
                  future: _loadUserInfo(),
                  builder: (BuildContext context, AsyncSnapshot snapshot1) {
                    if (snapshot1.hasData) {
                      return FutureBuilder(
                        future: _getAllUsersApi(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return snapshot.data[index].firstName
                                              .toLowerCase()
                                              .contains(
                                                  searchString.toLowerCase()) ||
                                          snapshot.data[index].lastName
                                              .toLowerCase()
                                              .contains(
                                                  searchString.toLowerCase())
                                      ? InkWell(
                                          splashColor: kPrimaryLightColor,
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                  builder: (context) =>
                                                      MessageRoom(
                                                    senderUser:
                                                        snapshot.data[index],
                                                    activeUser: snapshot1.data,
                                                  ),
                                                ));
                                          },
                                          child: Ink(
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    checkImagePath(snapshot
                                                        .data[index].imageUrl)),
                                              ),
                                              title: Text(snapshot
                                                      .data[index].firstName +
                                                  " " +
                                                  snapshot
                                                      .data[index].lastName),
                                              subtitle: Text(
                                                  snapshot.data[index].role),
                                            ),
                                          ),
                                        )
                                      : Container();
                                });
                          } else
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                        },
                      );
                    } else
                      return Container();
                  }),
            ),
          ),
        ],
      ),
    );
  }

  _getAllUsersApi() async {
    var response = await apiGetAllUsersChat();
    List<UserChatContactDTO> users = [];
    for (var u in response) {
      final UserChatContactDTO userChatContact = UserChatContactDTO.fromJson(u);
      users.add(userChatContact);
    }

    return users;
  }

  Widget buildSearch() {
    return Container(
      height: 46,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(143, 148, 251, 0.1),
                blurRadius: 20.0,
                offset: Offset(0, 10)),
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchString = value;
          });
        },
        controller: searchController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
          ),
          focusColor: kPrimaryLightColor,
          suffixIcon: searchString.isNotEmpty
              ? GestureDetector(
                  child: Icon(
                    Icons.close,
                    color: kPrimaryColor,
                  ),
                  onTap: () {
                    searchController.clear();
                    setState(() {
                      searchString = '';
                    });
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
