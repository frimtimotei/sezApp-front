import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sezapp/api/userApiService.dart';
import 'package:sezapp/constants.dart';
import 'package:sezapp/model/user/User.dart';
import 'package:sezapp/model/user/UserChatContactDTO.dart';
import 'package:sezapp/screens/chat/messageRoom.dart';

class ListAllUsersRoomPage extends StatefulWidget {
  const ListAllUsersRoomPage({Key key}) : super(key: key);

  @override
  _ListAllUsersRoomPageState createState() => _ListAllUsersRoomPageState();
}

class _ListAllUsersRoomPageState extends State<ListAllUsersRoomPage> {
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
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: FutureBuilder(
                  future: _loadUserInfo(),
                  builder: (BuildContext context, AsyncSnapshot snapshot1) {
                    if (snapshot1.hasData) {
                      return FutureBuilder(
                        future: _getAllRoomUsersApi(snapshot1.data.id),
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
                                                  snapshot
                                                      .data[index].lastMessage,
                                                  overflow:
                                                      TextOverflow.ellipsis),
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

  _getAllRoomUsersApi(userId) async {
    var response = await apiGetAllRoomChat(userId);
    print(response);
    List<UserChatRoomContact> users = [];
    for (var u in response) {
      final UserChatRoomContact userChatRoomContact =
          UserChatRoomContact.fromJson(u);
      users.add(userChatRoomContact);
    }

    return users;
  }
}
