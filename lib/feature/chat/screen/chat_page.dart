import 'package:chat_app/feature/chat/components/chat_room_list.dart';
import 'package:chat_app/feature/chat/components/search_field.dart';
import 'package:chat_app/feature/chat/components/search_user_list.dart';
import 'package:chat_app/feature/chat/provider/chat_provider.dart';
import 'package:chat_app/feature/login/screen/sign_in.dart';
import 'package:chat_app/utils/firestore_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    var chatProvider = Provider.of<ChatProvider>(context, listen: false);
    chatProvider.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chatProvider, _) {
      return Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Chats",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            chatProvider.myUserName,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {
                              chatProvider.setStatus(FirestoreConstants.STATUS_OFFLINE);
                              chatProvider.logout(context);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => SignIn(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.logout,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SearchField(
                chatProvider: chatProvider,
              ),
              chatProvider.isSearching
                  ? SearchUserList(chatProvider: chatProvider)
                  : ChatRoomList(
                      chatRoomStream: chatProvider.chatRoomStream,
                    ),
            ],
          ),
        ),
      );
    });
  }
}
