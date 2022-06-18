import 'package:chat_app/feature/chat/components/chat_users_list.dart';
import 'package:chat_app/feature/login/repository/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatRoomList extends StatefulWidget {
  final Stream<QuerySnapshot>? chatRoomStream;

  ChatRoomList({Key? key, required this.chatRoomStream}) : super(key: key);

  @override
  State<ChatRoomList> createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {
  String get myUserName => AuthService().getCurrentUser().toString();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
          itemCount: snapshot.data!.docs.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 16),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];
            String name =
            ds.id.replaceAll(myUserName, "").replaceAll("_", "");
            String chatRoomId = ds.id;

            Timestamp stamp = ds['lastMessageTime'];
            DateTime date = stamp.toDate();
            String time = DateFormat.jm().format(date);
            return ChatUsersList(
              username: name,
              secondaryText: ds['lastMessage'].toString(),
              image: 'images/userImage4.jpeg',
              time: time,
              isMessageRead: ds['isRead'] ? true : false,
              chatRoomId: chatRoomId,
            );
          },
        )
            : Container();
      },
    );
  }
}