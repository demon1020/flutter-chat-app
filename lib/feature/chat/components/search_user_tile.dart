import 'package:chat_app/feature/chat/provider/chat_provider.dart';
import 'package:chat_app/feature/chat/screen/chat_detail_page.dart';
import 'package:flutter/material.dart';

class SearchUserTile extends StatelessWidget {
  final String username;
  final String status;
  final ChatProvider chatProvider;

  SearchUserTile({Key? key, required this.username, required this.status, required this.chatProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        String roomId = chatProvider.getChatRoomIdByUsernames(chatProvider.myUserName, username);
        Map<String, dynamic> chatRoomInfoMap = {
          "chatUsers": [chatProvider.myUserName, username]
        };
        chatProvider.createChatRoom(roomId, chatRoomInfoMap);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ChatDetailPage(
              chatRoomId: roomId,
              userInfoMap: chatProvider.userInfoMap,
            ),
          ),
        );
      },
      leading: Icon(
        Icons.person,
        color: Colors.grey.shade400,
        size: 40,
      ),
      title: Text(
        username,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      subtitle: Text(
        status,
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      trailing: Icon(
        Icons.messenger_rounded,
        color: Colors.grey.shade400,
        size: 40,
      ),
    );
  }
}
