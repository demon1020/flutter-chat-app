import 'package:chat_app/feature/chat/repository/chat_service.dart';
import 'package:chat_app/feature/chat/screen/chat_detail_page.dart';
import 'package:chat_app/feature/login/repository/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isSearching = false;
  Map<String, dynamic>? userInfoMap;
  final TextEditingController _search = TextEditingController();
  AuthService _authService = AuthService();
  ChatService _databaseService = ChatService();

  String get myUserName => _authService.getCurrentUser().toString();

  //---------------------------------
  Stream<QuerySnapshot>? userStream;

  onSearching() async {
    userStream = await _databaseService.getUserByUsername(_search.text);
  }

  getChatRoomIdByUsernames(String? user1, String? user2) {
    if (user1!.substring(0, 1).codeUnitAt(0) >
        user2!.substring(0, 1).codeUnitAt(0)) {
      return "$user2\_$user1";
    } else {
      return "$user1\_$user2";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: searchField(),
      ),
      body: isSearching ? searchUserList() : Container(),
    );
  }

  Widget searchField() {
    return TextField(
        onChanged: (value) {
          if (_search.text != "") {
            setState(() {
              onSearching();
            });
          } else {
            isSearching = false;
          }
        },
        controller: _search,
        decoration: InputDecoration(
          labelText: "Search...",
          hintStyle: TextStyle(color: Colors.grey.shade400),
          contentPadding: EdgeInsets.all(8),
          border: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: () {
              _search.text = "";
            },
            icon: Icon(
              Icons.add,
              size: 20,
            ),
          ),
        ),
    );
  }

  Widget searchUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: userStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 16),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  userInfoMap = ds.data() as Map<String, dynamic>;
                  return searchUserTile(
                      userInfoMap!["name"], userInfoMap!["status"]);
                },
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget searchUserTile(String username, status) {
    return ListTile(
      onTap: () {
        String roomId = getChatRoomIdByUsernames(myUserName, username);
        Map<String, dynamic> chatRoomInfoMap = {
          "chatUsers": [myUserName, username],
          "lastMessage": "",
          "lastMessageTime": ""
        };
        _databaseService.createChatRoom(roomId, chatRoomInfoMap);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ChatDetailPage(
              chatRoomId: roomId,
              userInfoMap: userInfoMap,
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
