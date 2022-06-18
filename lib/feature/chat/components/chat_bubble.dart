import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatefulWidget {
  final Size size;
  final Map<String, dynamic> map;
  final String myUserName;

  ChatBubble({required this.size, required this.map, required this.myUserName});

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return messages(widget.size, widget.map);
  }

  messages(size, map) {
    Timestamp stamp = map['time'];
    DateTime date = stamp.toDate();
    String time = DateFormat.jm().format(date);

    return Container(
      width: size.width,
      alignment: map!['sender'] == widget.myUserName
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: map['sender'] == widget.myUserName
              ? Colors.white
              : Colors.grey.shade300,
        ),
        child: Column(
          children: [
            SelectableText(
              map['message'],
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            Text(
              time,
              style: TextStyle(
                fontSize: 10,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
