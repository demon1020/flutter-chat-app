import 'package:chat_app/feature/chat/repository/chat_service.dart';
import 'package:chat_app/feature/login/repository/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier{
  String myUserName = '';
  bool isSearching = false;
  Stream<QuerySnapshot>? chatRoomStream;
  Stream<QuerySnapshot>? userStream;
  Map<String, dynamic>? userInfoMap;
  Map<String, dynamic>? temp;
  TextEditingController? search;

  init() async {
    search = TextEditingController();
    getUserName();
    getChatRooms();
  }

  getUserName()async{
    myUserName = await AuthService().getCurrentUser().toString();
    notifyListeners();
  }

  void onSearching() async {
    isSearching = true;
    userStream = await ChatService().getUserByUsername(search!.text);
    notifyListeners();
  }

  String getChatRoomIdByUsernames(String? user1, String? user2) {
    if (user1!.substring(0, 1).codeUnitAt(0) >
        user2!.substring(0, 1).codeUnitAt(0)) {
      notifyListeners();
      return "$user2\_$user1";
    } else {
      notifyListeners();
      return "$user1\_$user2";
    }
  }

  void setStatus(String status) async {
    await ChatService().setStatus(status);
    notifyListeners();
  }

  void logout(BuildContext context) async{
    await AuthService().signOut(context);
    notifyListeners();
  }

  void createChatRoom(String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
    await ChatService().createChatRoom(chatRoomId, chatRoomInfoMap);
    notifyListeners();
  }

  void getChatRooms() async {
    chatRoomStream = await ChatService().getChatRoomList();
    notifyListeners();
  }
}