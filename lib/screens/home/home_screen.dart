import 'package:facechat/constants/constants_colors.dart';
import 'package:flutter/material.dart';

import '../sub/around_user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        automaticallyImplyLeading: false,
        leadingWidth: 140,
        elevation: 0,
        leading: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/logo/face_chat_text_logo.png',
              ),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AroundUserScreen(),
              ),
            ),
            behavior: HitTestBehavior.opaque,
            child: Center(
              child: Icon(
                Icons.location_on,
                color: kFontGray800Color,
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
