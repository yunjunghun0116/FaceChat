import 'package:facechat/screens/chat/chat_screen.dart';
import 'package:facechat/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/constants_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;

  Widget getScreen() {
    switch (_currentPageIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return Container();
      case 2:
        return const ChatScreen();
      case 3:
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: getScreen(),
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
