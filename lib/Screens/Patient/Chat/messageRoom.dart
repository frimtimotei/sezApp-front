import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sezapp/api/chat_api_service.dart';
import 'package:sezapp/conponents/inputField.dart';
import 'package:sezapp/model/message/ChatMessage.dart';
import 'package:sezapp/model/user/User.dart';
import 'package:sezapp/model/user/userChatContact.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../../../constants.dart';

final socketUrl = 'http://10.0.2.2:8080/ws';

class MessageRoom extends StatefulWidget {
  final UserChatContact senderUser;
  final User activeUser;

  const MessageRoom({Key key, this.senderUser,this.activeUser}) : super(key: key);

  @override
  _MessageRoomState createState() => _MessageRoomState();
}

class _MessageRoomState extends State<MessageRoom> {
  StompClient stompClient;
  String message = '';
  final textMessage = TextEditingController();
  List<ChatMessage> messageList=[];
  final _controller = ScrollController();



  @override
   initState() {
    connectStompClient();
    waitAllMessages();

    super.initState();

  }

  @override
  void dispose() {
    disconnectStompClient();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Timer(
      Duration(milliseconds: 30),
          () => _controller.jumpTo(_controller.position.maxScrollExtent),
    );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Container(
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: kPrimaryLightColor,
                      size: 18,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        checkImagePath(widget.senderUser.imageUrl)),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.senderUser.firstName +
                              " " +
                              widget.senderUser.lastName,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Offline",
                          style:
                              TextStyle(color: kGreyTextColor, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.grey.shade700,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: kLightColor,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemCount: messageList.length,
                  controller: _controller,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Message(
                      message: messageList[index],
                      recipientUser: widget.senderUser),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: SafeArea(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      height: 43,
                      decoration: BoxDecoration(
                          color: kPrimaryLightColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(40)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextField(
                              controller: textMessage,
                              decoration: InputDecoration(
                                hintText: "Type a message...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                sendMessage();
                              },
                              icon: Icon(
                                Icons.send,
                                color: kPrimaryLightColor,
                              ))
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String checkImagePath(String imagePath) {
    if (imagePath == null)
      return "https://sezapp-images.s3.eu-central-1.amazonaws.com/profilePicture.jpg";
    else
      return imagePath;
  }

  void connectStompClient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString("jwt");
    stompClient = StompClient(
      config: StompConfig(
        url: 'wss://sezapp-backend.herokuapp.com/ws',
        onConnect: onConnect,
        beforeConnect: () async {
          print('waiting to connect...');
          await Future.delayed(Duration(milliseconds: 200));
          print('connecting...');
        },
        onWebSocketError: (dynamic error) => print(error.toString()),
        stompConnectHeaders: {'Authorization': "Bearer " + jwt},
        webSocketConnectHeaders: {'Authorization': "Bearer " + jwt},
      ),
    );

    stompClient.activate();
  }

  void onConnect(StompFrame frame) {
    stompClient.subscribe(
      destination: "/user/" + widget.activeUser.id + "/queue/messages",
      callback: (frame) async {
        var result = json.decode(frame.body);
        var message = await findChatMessage(result['id']);

        ChatMessage chatMessage = ChatMessage.fromJson(message);

        print(message);
        setState(() {
            messageList.add(chatMessage);
        });
      },
    );

    print("connected");
  }

  void disconnectStompClient() {
    if (stompClient != null) {
      stompClient.deactivate();
      print("disconnected");
    }
  }


  findChatMessage(id) async {
    var response = await apiFindChatMessage(id);
    var decResponse = jsonDecode(response.body);
    return decResponse;
  }
  void waitAllMessages()async {
    messageList=await findAllChatMessage();
    setState(() {

    });
  }

  findAllChatMessage() async {
    var response = await apiFindAllChatMessage(widget.activeUser.id,widget.senderUser.id);
    var decResponse = jsonDecode(response.body);

    List<ChatMessage> chatMessages = (decResponse as List)
        .map((data) => ChatMessage.fromJson(data))
        .toList();

    return chatMessages;
  }

  void sendMessage() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    final Map<String, dynamic> messageData = {
      'senderId': widget.activeUser.id,
      'recipientId': widget.senderUser.id,
      'senderName': widget.activeUser.firstName,
      'recipientName': widget.senderUser.firstName,
      'content': textMessage.text,
      'timestamp': formattedDate
    };



    stompClient.send(
      destination: '/app/chat',
      body: json.encode(messageData),
    );

   setState(() {
    messageList.add(ChatMessage(
        id: "",
        chatId: widget.activeUser.id+"_"+widget.senderUser.id,
        senderId: widget.activeUser.id,
        recipientId: widget.senderUser.id,
        recipientName: widget.activeUser.firstName,
        senderName: widget.senderUser.firstName,
        content: textMessage.text,
        timestamp: formattedDate,
        status: "RECIVED"),
    );

    textMessage.text="";
   });



  }


}

class Message extends StatelessWidget {
  const Message({Key key, @required this.message, @required this.recipientUser})
      : super(key: key);

  final ChatMessage message;
  final UserChatContact recipientUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: (message.senderId == recipientUser.id)
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: [
        if (message.senderId == recipientUser.id) ...[
          CircleAvatar(
            radius: 12,
            backgroundImage:
                NetworkImage(checkImagePath(recipientUser.imageUrl)),
          ),
          SizedBox(width: 10,)
        ],
        Container(
          margin: EdgeInsets.only(top: 15),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color: kPrimaryLightColor.withOpacity(
                  (message.senderId == recipientUser.id) ? 0.1 : 1),
              borderRadius: BorderRadius.circular(30)),
          child: Text(
            message.content,
            style: TextStyle(
                color: (message.senderId == recipientUser.id)
                    ? kPrimaryColor
                    : Colors.white),
          ),
        ),
      ],
    );
  }

  String checkImagePath(String imagePath) {
    if (imagePath == null)
      return "https://sezapp-images.s3.eu-central-1.amazonaws.com/profilePicture.jpg";
    else
      return imagePath;
  }
}
