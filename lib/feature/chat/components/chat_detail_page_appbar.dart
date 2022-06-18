import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatDetailPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  Stream<DocumentSnapshot>? userInfoStream;
  ChatDetailPageAppBar(this.userInfoStream);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: true,
      title: StreamBuilder<DocumentSnapshot>(
        stream: userInfoStream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Container(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage("images/userImage1.jpeg"),
                    maxRadius: 20,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          snapshot.data!['name'],
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          snapshot.data!['status'],
                          style: TextStyle(
                              color: (snapshot.data!['status'] == 'Online')
                                  ? Colors.white
                                  : Colors.red,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.call,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.video_call,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
