import 'package:facechat/constants/constants_colors.dart';
import 'package:facechat/screens/chat/open_chat/open_chat_screen.dart';
import 'package:facechat/screens/chat/personal_chat/personal_chat_screen.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _chatIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        leadingWidth: 80,
        leading: Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 24),
          child: Text(
            '채팅',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kFontGray900Color,
              height: 28 / 20,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kFontGray50Color,
                ),
              ),
            ),
            child: Row(
              children: [
                kCustomTabButton(index: 0, title: '개인채팅방'),
                kCustomTabButton(index: 1, title: '오픈채팅방'),
              ],
            ),
          ),
          Expanded(
            child: _chatIndex == 0
                ? const PersonalChatScreen()
                : const OpenChatScreen(),
          ),
        ],
      ),
    );
  }

  Widget kCustomTabButton({
    required int index,
    required String title,
  }) {
    return GestureDetector(
      onTap: () => setState(() => _chatIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        width: 120,
        height: 40,
        decoration: _chatIndex == index
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: kMainColor,
                    width: 2,
                  ),
                ),
              )
            : null,
        child: Text(
          title,
          style: TextStyle(
            color: _chatIndex == index ? kFontGray800Color : kFontGray200Color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            height: 20 / 16,
          ),
        ),
      ),
    );
  }
}
