import 'package:cloud_firestore/cloud_firestore.dart';

//
final  CollectionReference USERS_COLLECTION = FirebaseFirestore.instance.collection("users");
final CollectionReference CHATROOM_COLLECTION = FirebaseFirestore.instance.collection("chatroom");
const String CHATS_COLLECTION = "chats";

const String USERS_UID = "uid";
const String USERS_USERNAME = "username";
const String USERS_NAME = "name";
const String USERS_STATUS = "status";
const String USERS_TIME = "time";
const String USERS_IMAGE_URL= "imageUrl";
const String USERS_EMAIL = "email";
const String USERS_PHONE = "phone";
const String USERS_STATUS_ONLINE = "Online";
const String USERS_STATUS_OFFLINE = "Offline";
