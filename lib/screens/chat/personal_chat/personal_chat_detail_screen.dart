import 'package:facechat/constants/constants_colors.dart';
import 'package:facechat/controllers/user_controller.dart';
import 'package:facechat/models/personal_chat/personal_chat.dart';
import 'package:facechat/services/firebase_chat_service.dart';
import 'package:facechat/services/firebase_user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
          future: FirebaseChatService.getPersonalChat(
              personalChatId: personalChatId),
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
                        future: FirebaseUserService.get(
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
                    body: Column(children: [
                      const Spacer(),
                      Container(
                        child: SafeArea(
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            padding: const EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              border: Border.all(color: kDarkGray20Color),
                              color: kDarkGray10Color,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: kFontGray800Color,
                                      height: 18 / 13,
                                      letterSpacing: -0.5,
                                    ),
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                      constraints: BoxConstraints(
                                        minHeight: 42,
                                        maxHeight: 100,
                                      ),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      counterText: '',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                SvgPicture.asset(
                                    'assets/icons/svg/camera_28px.svg'),
                                const SizedBox(width: 16),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: kFontGray200Color,
                                  ),
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: SvgPicture.asset(
                                      'assets/icons/svg/send_chat_24px.svg',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                              ],
                            ),
                          ),
                        ),
                      )
                    ]),
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
