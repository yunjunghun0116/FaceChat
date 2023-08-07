import 'package:facechat/constants/constants_colors.dart';
import 'package:facechat/controllers/user_controller.dart';
import 'package:facechat/models/personal_chat/personal_chat.dart';
import 'package:facechat/screens/chat/personal_chat/personal_chat_detail_screen.dart';
import 'package:facechat/services/personal_chat_service.dart';
import 'package:facechat/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user/user.dart';

class PersonalChatScreen extends StatelessWidget {
  const PersonalChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, controller, child) {
      if (controller.user == null) return Container();
      String userId = controller.user!.id;

      return FutureBuilder(
        future: PersonalChatService().getUserChat(userId: userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<PersonalChat> chatList = snapshot.data as List<PersonalChat>;
            return ListView(
              children: chatList
                  .map(
                    (personalChat) => GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalChatDetailScreen(
                            personalChatId: personalChat.id,
                          ),
                        ),
                      ),
                      behavior: HitTestBehavior.opaque,
                      child: Builder(
                        builder: (context) {
                          String partnerUserId = personalChat.userIdList
                              .where((element) => element != userId)
                              .first;
                          return FutureBuilder(
                            future: UserService.getUser(userId: partnerUserId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                User? partnerUser = snapshot.data;
                                if (partnerUser == null) return Container();
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  width: double.infinity,
                                  height: 80,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 54,
                                        height: 54,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(54),
                                          color: kDarkGray20Color,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              partnerUser.profileImage,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            partnerUser.name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              height: 20 / 16,
                                              letterSpacing: -0.5,
                                              fontWeight: FontWeight.bold,
                                              color: kFontGray800Color,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          FutureBuilder(
                                            builder: (context, snapshot) {
                                              return Text(
                                                '마지막 채팅 내용',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  height: 20 / 15,
                                                  color: kFontGray500Color,
                                                  letterSpacing: -0.5,
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }
                              return Container();
                            },
                          );
                        },
                      ),
                    ),
                  )
                  .toList(),
            );
          }
          return Container();
        },
      );
    });
  }
}
