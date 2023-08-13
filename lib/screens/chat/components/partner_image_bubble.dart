import 'package:facechat/screens/chat/components/show_date_container.dart';
import 'package:flutter/material.dart';
import '../../../../constants/constants_colors.dart';
import '../../../../models/chat/chat.dart';
import '../../../../services/user_service.dart';
import '../../../../utils/chat_utils.dart';
import 'image_container.dart';

class PartnerImageBubble extends StatelessWidget {
  final Chat chat;
  final String? lastSenderId;
  final String? lastChatDate;
  const PartnerImageBubble({
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showImage(lastSenderId, chat.senderId))
                FutureBuilder(
                  future: UserService.get(
                      fieldName: 'profileImage', userId: chat.senderId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String image = snapshot.data as String;
                      return Container(
                        margin: EdgeInsets.only(top: topMargin, right: 14),
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                            color: kDarkGray20Color,
                            borderRadius: BorderRadius.circular(36),
                            image: DecorationImage(
                                image: NetworkImage(
                              image,
                            ))),
                      );
                    }
                    return Container(
                      margin: const EdgeInsets.only(right: 14),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: kDarkGray20Color,
                        borderRadius: BorderRadius.circular(36),
                      ),
                    );
                  },
                )
              else
                Container(width: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ImageContainer(
                      topMargin: topMargin, imageList: chat.message as List),
                  Builder(
                    builder: (context) {
                      DateTime dateTime = DateTime.parse(chat.timeStamp);
                      return Container(
                        margin: const EdgeInsets.only(left: 8),
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
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
