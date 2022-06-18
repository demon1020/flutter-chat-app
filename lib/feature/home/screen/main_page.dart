import 'package:chat_app/feature/chat/provider/chat_provider.dart';
import 'package:chat_app/utils/firestore_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../chat/screen/chat_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver{
  int currentIndex = 0;
  late PageController pageController;

  var _pages = [
    ChatPage(),
    Center(child: Text('Posts')),
    Center(child: Text('call logs')),
    Center(child: Text('Profile'))
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    WidgetsBinding.instance!.addObserver(this);
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    var chatProvider = Provider.of<ChatProvider>(context, listen: false);
    if (state == AppLifecycleState.resumed) {
      //online
      chatProvider.setStatus(FirestoreConstants.STATUS_ONLINE);
    } else {
      //offline
      chatProvider.setStatus(FirestoreConstants.STATUS_OFFLINE);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
            controller: pageController,
            children: _pages,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            }),
        bottomNavigationBar: bottomItems());
  }

  BottomNavigationBar bottomItems() {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      onTap: (int index) {
        setState(() {
          currentIndex = index;
        });
        pageController.animateToPage(
          index,
          duration: Duration(
            milliseconds: 200,
          ),
          curve: Curves.linear,
        );
      },
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.call,
          ),
          label: 'Calls',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
    );
  }
}
