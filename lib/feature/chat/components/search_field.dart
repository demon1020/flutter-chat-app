import 'package:chat_app/feature/chat/provider/chat_provider.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final ChatProvider chatProvider;

  SearchField({Key? key, required this.chatProvider}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: TextField(
        onChanged: (v) {
          if (widget.chatProvider.search!.text != "") {
            setState(() {
              widget.chatProvider.onSearching();
            });
          }
        },
        controller: widget.chatProvider.search,
        decoration: InputDecoration(
          hintText: "Search...",
          hintStyle: TextStyle(color: Colors.grey.shade400),
          contentPadding: EdgeInsets.all(8),
          suffixIcon: Visibility(
            visible: widget.chatProvider.isSearching,
            replacement: IconButton(
              onPressed: () {
                widget.chatProvider.isSearching = true;
              },
              icon: Icon(Icons.search),
            ),
            child: CloseButton(
              onPressed: () {
                setState(() {
                  widget.chatProvider.search!.text = "";
                  widget.chatProvider.isSearching = false;
                  widget.chatProvider.getChatRooms();
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
