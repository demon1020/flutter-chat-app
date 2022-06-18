import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 16.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://media.popculture.com/2018/06/johnny-depp-beard-ring-20037228.jpeg'),
                  maxRadius: 100,
                  child: Container(
                    margin: EdgeInsets.only(top: 135, left: 135),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.circular(50.0)
                    ),
                    child: IconButton(icon: Icon(Icons.edit,color: Colors.white,),
                      onPressed: (){},),
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(16.0, 270.0, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.only(top: 16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Johny Depp", style: Theme.of(context).textTheme.headline6,),
                                  ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text("Actor"),
                                    subtitle: Text("UK"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(title: Text("User information"),),
                        Divider(),
                        ListTile(
                          title: Text("Email"),
                          subtitle: Text("babu@gmail.com"),
                          leading: Icon(Icons.email),
                        ),
                        ListTile(
                          title: Text("Phone"),
                          subtitle: Text("+977-9815225566"),
                          leading: Icon(Icons.phone),
                        ),
                        ListTile(
                          title: Text("Joined Date"),
                          subtitle: Text("15 February 2019"),
                          leading: Icon(Icons.calendar_view_day),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            )
          ],
        ),
      ),
    );
  }
}