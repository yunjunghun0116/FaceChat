import 'package:facechat/controllers/user_controller.dart';
import 'package:facechat/models/user/user.dart';
import 'package:facechat/screens/sub/around_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../constants/constants_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;

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
          ))),
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
      bottomNavigationBar: Container(
        color: kWhiteColor,
        child: SafeArea(
          child: Container(
            color: kWhiteColor,
            width: double.infinity,
            height: 60,
            child: Row(
              children: [
                kBottomNavigationBarItem(
                  activeImage: 'assets/icons/nav/nav_home_active.svg',
                  inactiveImage: 'assets/icons/nav/nav_home_inactive.svg',
                  index: 0,
                ),
                kBottomNavigationBarItem(
                  activeImage: 'assets/icons/nav/nav_community_active.svg',
                  inactiveImage: 'assets/icons/nav/nav_community_inactive.svg',
                  index: 1,
                ),
                kBottomNavigationBarItem(
                  activeImage: 'assets/icons/nav/nav_chat_active.svg',
                  inactiveImage: 'assets/icons/nav/nav_chat_inactive.svg',
                  index: 2,
                ),
                kBottomNavigationBarItem(
                  activeImage: 'assets/icons/nav/nav_my_active.svg',
                  inactiveImage: 'assets/icons/nav/nav_my_inactive.svg',
                  index: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget kBottomNavigationBarItem(
      {required String activeImage,
      required String inactiveImage,
      required int index}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentPageIndex = index),
        child: Container(
          color: kWhiteColor,
          child: SvgPicture.asset(
            _currentPageIndex == index ? activeImage : inactiveImage,
          ),
        ),
      ),
    );
  }
}
