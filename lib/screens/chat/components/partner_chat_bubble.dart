import 'package:facechat/screens/chat/components/show_date_container.dart';
import 'package:facechat/services/user_service.dart';
import 'package:flutter/material.dart';
import '../../../../constants/constants_colors.dart';
import '../../../../models/chat/chat.dart';
import '../../../../utils/chat_utils.dart';

class PartnerChatBubble extends StatelessWidget {
  final Chat chat;
  final String? lastSenderId;
  final String? lastChatDate;
  const PartnerChatBubble({
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
                  Container(
                    margin: EdgeInsets.only(top: topMargin),
                    padding: const EdgeInsets.only(
                        left: 16, right: 20, top: 10, bottom: 10),
                    constraints: const BoxConstraints(maxWidth: 208),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(20),
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
