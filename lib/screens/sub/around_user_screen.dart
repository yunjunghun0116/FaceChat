import 'package:facechat/constants/constants_colors.dart';
import 'package:facechat/controllers/user_controller.dart';
import 'package:facechat/models/user/user.dart';
import 'package:facechat/services/firebase_chat_service.dart';
import 'package:facechat/services/firebase_user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AroundUserScreen extends StatefulWidget {
  const AroundUserScreen({Key? key}) : super(key: key);

  @override
  State<AroundUserScreen> createState() => _AroundUserScreenState();
}

class _AroundUserScreenState extends State<AroundUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        foregroundColor: kFontGray800Color,
        elevation: 0,
        title: Text(
          '내 주변 사람들',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            height: 28 / 18,
            letterSpacing: -0.5,
            color: kFontGray800Color,
          ),
        ),
      ),
      body: Consumer<UserController>(
        builder: (context, controller, widget) {
          if (controller.user == null) return Container();
          String userId = controller.user!.id;
          return FutureBuilder(
            future: FirebaseUserService.getAroundUser(userId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<User> userList = snapshot.data as List<User>;
                return ListView(
                  children: userList
                      .map(
                        (partner) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          width: double.infinity,
                          height: 106,
                          child: Row(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kDarkGray20Color,
                                  image: DecorationImage(
                                    image: NetworkImage(partner.profileImage),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(partner.name),
                                    Text(
                                      '성별 : ${partner.gender}성',
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: ()async{
                                  String? chatId = await FirebaseChatService.startPersonalChat(user1Id: userId, user2Id: partner.id);
                                  print('$chatId 채팅방 생성 완료');
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 11,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22),
                                    color: kSubColor1,
                                  ),
                                  child: Text(
                                    '채팅하기',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: kMainColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                );
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}
