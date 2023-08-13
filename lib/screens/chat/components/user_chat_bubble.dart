import 'package:facechat/constants/constants_colors.dart';
import 'package:facechat/models/chat/chat.dart';
import 'package:facechat/screens/chat/components/show_date_container.dart';
import 'package:flutter/material.dart';

class UserChatBubble extends StatelessWidget {
  final Chat chat;
  final String? lastSenderId;
  final String? lastChatDate;
  const UserChatBubble({
    Key? key,
    required this.chat,
    required this.lastSenderId,
    required this.lastChatDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double topMargin = lastSenderId == chat.senderId ? 8 : 20;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShowDateContainer(lastChatDate: lastChatDate,chatDate: chat.timeStamp),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Builder(
                builder: (context) {
                  DateTime dateTime = DateTime.parse(chat.timeStamp);
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: Text(
                      '${dateTime.hour >= 12 ? '오후' : '오전'} ${dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 10,
                        height: 12 / 10,
                        color: kFontGray500Color,
                      ),
                    ),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(top: topMargin),
                padding: const EdgeInsets.only(
                    left: 20, right: 16, top: 10, bottom: 10),
                constraints: const BoxConstraints(maxWidth: 208),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(20),
                  ),
                  color: kMainColor,
                ),
                child: Text(
                  chat.message,
                  style: TextStyle(
                    fontSize: 13,
                    height: 18 / 13,
                    color: kFontGray0Color,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
