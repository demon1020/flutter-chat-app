import 'package:chat_app/feature/chat/components/search_user_tile.dart';
import 'package:chat_app/feature/chat/provider/chat_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchUserList extends StatelessWidget {
  final ChatProvider chatProvider;

  SearchUserList({Key? key, required this.chatProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: chatProvider.userStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
          itemCount: snapshot.data!.docs.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 16),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];
            chatProvider.userInfoMap = ds.data() as Map<String, dynamic>;
            return chatProvider.userInfoMap!["name"] != null
                ? SearchUserTile(
                username: chatProvider.userInfoMap!["name"],
                status: chatProvider.userInfoMap!["status"],
                chatProvider: chatProvider)
                : Center(child: Container());
          },
        )
            : Center(child: Container());
      },
    );
  }
}
