import 'package:chat_app/feature/chat/components/chat_bubble.dart';
import 'package:chat_app/feature/chat/components/chat_detail_page_appbar.dart';
import 'package:chat_app/feature/login/repository/auth_service.dart';
import 'package:chat_app/feature/chat/repository/chat_service.dart';
import 'package:chat_app/feature/chat/components/bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

enum MessageType {
  Receiver,
  Sender,
}

class ChatDetailPage extends StatefulWidget {

  final Map<String, dynamic>? userInfoMap;
  final String chatRoomId;
  ChatDetailPage({Key? key, this.userInfoMap, required this.chatRoomId}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _message = TextEditingController();
  ChatService _databaseService = ChatService();
  AuthService _authService = AuthService();
  Stream<QuerySnapshot>? messageStream;
  Stream<DocumentSnapshot>? userInfoStream;
  String get myUserName => _authService.getCurrentUser().toString();
  late String messageId;

  updateMessageReadStatus() async{
     await _databaseService.setMessageReadStatus(widget.chatRoomId);
  }
  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      DateTime lastMessageTime = DateTime.now();
      Map<String, dynamic> messages = {
        "sender": myUserName,
        "message": _message.text,
        "time": lastMessageTime,
      };
      //messageId
      if (messageId == "") {
        messageId = randomAlphaNumeric(12);
      }

      _databaseService.addMessage(widget.chatRoomId, messages);

      Map<String, dynamic> lastMessage = {
        "lastMessage": _message.text,
        "lastMessageTime": lastMessageTime,
        "isRead": false,
      };
      _databaseService.UpdateLastMessage(widget.chatRoomId, lastMessage);
      _message.clear();

    } else {
      print("Enter Some Text");
    }
  }

  getChatUserInfo() async{
    userInfoStream = await _databaseService.getChatUserInfo(widget.userInfoMap);
    messageStream = await _databaseService.getChatUserMessages(widget.chatRoomId);
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    getChatUserInfo();
    updateMessageReadStatus();
    messageId="";
  }

  Widget messageEntryField(){
    return Row(
      children: <Widget>[
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(30),
          ),
          child: IconButton(
            onPressed: () {
              BottomSheets();
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextField(
            controller: _message,
            decoration: InputDecoration(
                hintText: "Type message...",
                hintStyle: TextStyle(color: Colors.grey.shade500),
                border: InputBorder.none),
          ),
        ),

        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            padding: EdgeInsets.only(right: 2, bottom: 1),
            child: FloatingActionButton(
              mini: true,
              onPressed: () {
                onSendMessage();
              },
              child: Icon(
                Icons.send,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: ChatDetailPageAppBar(userInfoStream),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 40),
              child: StreamBuilder<QuerySnapshot>(
                stream: messageStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data!.docs.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        return ChatBubble(size: size,map: map,myUserName: myUserName,);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 5),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: messageEntryField(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
