import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sezapp/api/chat_api_service.dart';
import 'package:sezapp/conponents/inputField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

// use this if you are using emulator. localhost is mapped to 10.0.2.2 by default.
final socketUrl = 'http://10.0.2.2:8080/ws';

class ChatPage extends StatefulWidget {
  ChatPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void dispose() {
    if (stompClient != null) {
      stompClient.deactivate();
    }

    super.dispose();
  }
  StompClient stompClient;

  String message = '';
  final text = TextEditingController();
  List<String> messageList= [];

  void onConnect(StompFrame frame) {

    stompClient.subscribe(
      destination: "/user/" + "3" + "/queue/messages",
      callback: (frame)async {
        var result = json.decode(frame.body);
        var message= await findChatMessage(result['id']);

        print(message['content']);
        setState(() {
          messageList.add(message['content']);
        });

      },

    );

    print("connected");

  }

  @override
  void initState() {
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://10.0.2.2:8080/ws',
        onConnect: onConnect,
        beforeConnect: () async {
          print('waiting to connect...');
          await Future.delayed(Duration(milliseconds: 200));
          print('connecting...');
        },
        onWebSocketError: (dynamic error) => print(error.toString()),
        stompConnectHeaders: {'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJwYXRpZW50MkBtYWlsLmNvbSIsImV4cCI6MTYyNDUxMzY3MSwiaWF0IjoxNjI0NDQxNjcxfQ.rVL3W42HF09Z3Yi5jFV-VAnbVRBc-tB-UrYmmOqdzFM'},
        webSocketConnectHeaders: {'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJwYXRpZW50MkBtYWlsLmNvbSIsImV4cCI6MTYyNDUxMzY3MSwiaWF0IjoxNjI0NDQxNjcxfQ.rVL3W42HF09Z3Yi5jFV-VAnbVRBc-tB-UrYmmOqdzFM'},
      ),
    );

    stompClient.activate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your message from server:',
            ),
            Text(
              '$message',
              style: Theme.of(context).textTheme.bodyText1,
            ),

            InputFiled(hintText: "Text", obscuredText: false, controller: text, validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },),

            OutlineButton(onPressed: () {
              final Map<String, dynamic> messageData = {
                'senderId': '3',
                'recipientId': '1',
                'senderName': "patient2",
                'recipientName': "timo",
                'content': text.text,
              };

              stompClient.send(
                destination: '/app/chat',
                body: json.encode(messageData),
              );
              setState(() {
                messageList.add(text.text);
                text.text="";
              });


            },
            child: Text("send"),),
            
            Expanded(child: getMessageList())
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  ListView getMessageList(){
    List<Widget> listWidget=[];

    for(String message in messageList)
      {
        listWidget.add(
          ListTile(
            title: Container(
              child: Padding(padding:const EdgeInsets.all(8),
              child: Text(
                message
              ),),
            ),
          )
        );
      }

    return ListView(
      children: listWidget,
    );
  }



  findChatMessage(id) async{
    var response= await apiFindChatMessage(id);
    var decResponse= jsonDecode(response.body);
    return decResponse;
  }
}
