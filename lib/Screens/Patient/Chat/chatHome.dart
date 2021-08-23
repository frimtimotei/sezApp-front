
import 'package:flutter/material.dart';
import 'package:sezapp/Screens/Patient/Chat/listAllUsersPage.dart';
import 'package:sezapp/Screens/Patient/Chat/listChatRoomUsers.dart';
import 'package:sezapp/components/splashScreen.dart';

import '../../../constants.dart';

class ChatHome extends StatelessWidget {
  const ChatHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,

      child: Scaffold(appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // here the desired height
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: true,

          title: Text(
            "Inbox",
            style: TextStyle(
              fontSize: 20,
              color: kPrimaryColor,
              fontWeight: FontWeight.w300,
            ),
          ),
          bottom: TabBar(
            indicatorColor: kPrimaryLightColor,
            labelColor: kPrimaryLightColor,
            unselectedLabelColor: kPrimaryColor,
            tabs: [
              Tab(text: "Chat",),
              Tab(text: "Users",),
            ],),
        ),

      ),
        body: TabBarView(children: [
          ListAllUsersRoomPage(),
          ListAllUsersPage()

        ],

        ),
      ),

    );
  }
}
