import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facechat/constants/constants_colors.dart';
import 'package:facechat/controllers/user_controller.dart';
import 'package:facechat/models/chat/chat.dart';
import 'package:facechat/models/personal_chat/personal_chat.dart';
import 'package:facechat/services/personal_chat_service.dart';
import 'package:facechat/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/custom_input_container.dart';

class PersonalChatDetailScreen extends StatelessWidget {
  final String personalChatId;
  const PersonalChatDetailScreen({
    Key? key,
    required this.personalChatId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: FutureBuilder(
          future: PersonalChatService().getChatRoom(chatId: personalChatId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              PersonalChat personalChat = snapshot.data as PersonalChat;
              return Consumer<UserController>(
                builder: (context, controller, child) {
                  if (controller.user == null) return Container();
                  String userId = controller.user!.id;
                  String partnerUserId = personalChat.userIdList
                      .where((element) => element != userId)
                      .first;
                  return Scaffold(
                    backgroundColor: kWhiteColor,
                    appBar: AppBar(
                      backgroundColor: kWhiteColor,
                      foregroundColor: kFontGray800Color,
                      elevation: 0,
                      title: FutureBuilder(
                        future: UserService.get(
                          fieldName: 'name',
                          userId: partnerUserId,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            String partnerName = snapshot.data as String;
                            return Text(
                              partnerName,
                              style: TextStyle(
                                fontSize: 18,
                                letterSpacing: -0.5,
                                height: 28 / 18,
                                fontWeight: FontWeight.bold,
                                color: kFontGray800Color,
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                    body: Column(
                      children: [
                        Expanded(
                          child: StreamBuilder(
                            stream: PersonalChatService()
                                .getChat(chatId: personalChatId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                QuerySnapshot<Map<String, dynamic>>
                                    chatSnapshot = snapshot.data
                                        as QuerySnapshot<Map<String, dynamic>>;
                                return ListView(
                                  children: chatSnapshot.docs
                                      .map((queryDocumentSnapshot) {
                                    Chat chat = Chat.fromJson(
                                        queryDocumentSnapshot.data());
                                    return Container(
                                      width: double.infinity,
                                      height: 50,
                                      color: kFontGray200Color,
                                    );
                                  }).toList(),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                        CustomInputContainer(
                          chatId: personalChatId,
                          userId: userId,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return Scaffold(
              backgroundColor: kWhiteColor,
              appBar: AppBar(
                backgroundColor: kWhiteColor,
                foregroundColor: kFontGray800Color,
                elevation: 0,
              ),
            );
          }),
    );
  }
}
