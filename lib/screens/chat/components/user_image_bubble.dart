import 'package:facechat/screens/chat/components/show_date_container.dart';
import 'package:flutter/material.dart';
import '../../../../constants/constants_colors.dart';
import '../../../../models/chat/chat.dart';
import 'image_container.dart';

class UserImageBubble extends StatelessWidget {
  final Chat chat;
  final String? lastSenderId;
  final String? lastChatDate;
  const UserImageBubble({
    Key? key,
    required this.chat,
    this.lastSenderId,
    this.lastChatDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double topMargin = lastSenderId == chat.senderId ? 8 : 20;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShowDateContainer(
              lastChatDate: lastChatDate, chatDate: chat.timeStamp),
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
              ImageContainer(
                  topMargin: topMargin, imageList: chat.message as List),
            ],
          ),
        ],
      ),
    );
  }
}
