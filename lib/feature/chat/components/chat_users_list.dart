import 'package:chat_app/feature/chat/screen/chat_detail_page.dart';
import 'package:chat_app/feature/login/repository/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatUsersList extends StatefulWidget {
  final String username;
  final String secondaryText;
  final String image;
  final String time;
  final bool isMessageRead;
  final String? chatRoomId;

  ChatUsersList(
      {required this.chatRoomId,
      required this.username,
      required this.secondaryText,
      required this.image,
      required this.time,
      required this.isMessageRead});

  @override
  _ChatUsersListState createState() => _ChatUsersListState();
}

class _ChatUsersListState extends State<ChatUsersList> {
  Map<String, dynamic>? chatUserInfoMap;
  AuthService _authService = AuthService();

  String get myUserName => _authService.getCurrentUser().toString();
  String profilePicUrl = "", name = "", chatRoomId = "";

  collectingData() {
    name = widget.username;
    chatRoomId = widget.chatRoomId!;
    return FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: name)
        .get()
        .then((value) {
      setState(() {
        chatUserInfoMap = value.docs[0].data();
      });
    });
  }

  @override
  void initState() {
    collectingData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ChatDetailPage(
              chatRoomId: chatRoomId,
              userInfoMap: chatUserInfoMap,
            ),
          ),
        );
      },
      leading: CircleAvatar(
        backgroundImage: AssetImage(widget.image),
        maxRadius: 30,
      ),
      title: Text(
        widget.username,
        style: TextStyle(fontSize: 18),
      ),
      subtitle: Text(
        widget.secondaryText,
        style: TextStyle(fontSize: 14, color: widget.isMessageRead ? Colors.grey.shade500 : Colors.pinkAccent),
      ),
      trailing: Text(
        widget.time,
        style: TextStyle(
            fontSize: 12,
            color: widget.isMessageRead ? Colors.grey.shade500 : Colors.pinkAccent),
      ),
    );
  }
}
