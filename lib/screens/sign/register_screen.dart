import 'package:facechat/screens/sign/register_email_screen.dart';
import 'package:facechat/screens/sign/register_name_screen.dart';
import 'package:facechat/screens/sign/register_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/constants_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _pageIndex = 0;

  late String _userEmail;
  late String _userPassword;
  late String _userName;
  late String _userProfileImage;

  Widget getScreen() {
    switch (_pageIndex) {
      case 0:
        return RegisterEmailScreen(
          next: (String email) {
            setState(() {
              _userEmail = email;
              _pageIndex++;
            });
          },
        );
      case 1:
        return RegisterPasswordScreen(
          next: (String password) {
            setState(() {
              _userPassword = password;
              _pageIndex++;
            });
          },
        );
      case 2:
        return RegisterNameScreen(
          next: (String name, String image) {
            setState(() {
              _userName = name;
              _userProfileImage = image;
            });
            Map<String, dynamic> userData = {
              'name': _userName,
              'email': _userEmail,
              'password': _userPassword,
              'profileImage': _userProfileImage,
            };
            print(userData);

            Map<String, dynamic> userSignUpInformation = {
              'apple': '',
              'naver': '',
              'kakao': '',
              'google': '',
              'app_email': _userEmail,
              'app_password': _userPassword,
            };

            print(userSignUpInformation);
          },
        );
      default:
        return Container();
    }
  }

  void next() {
    if (_pageIndex == 2) {
      Navigator.pop(context);
      return;
    }
    setState(() => _pageIndex++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        foregroundColor: kFontGray800Color,
        backgroundColor: kWhiteColor,
        leadingWidth: 48,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (_pageIndex == 0) {
              Navigator.pop(context);
              return;
            }
            setState(() => _pageIndex--);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 20),
            alignment: Alignment.center,
            child: SvgPicture.asset('assets/icons/svg/arrow_left_28px.svg'),
          ),
        ),
        actions: [
          ...[0, 1, 2]
              .map(
                (index) => index == _pageIndex
                    ? Center(
                        child: Container(
                          margin: const EdgeInsets.only(left: 12),
                          alignment: Alignment.center,
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: kMainColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 14,
                              color: kFontGray0Color,
                              fontWeight: FontWeight.bold,
                              height: 20 / 14,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Container(
                          margin: const EdgeInsets.only(left: 12),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: kFontGray100Color,
                          ),
                        ),
                      ),
              )
              .toList(),
          const SizedBox(width: 20),
        ],
        elevation: 0,
      ),
      body: getScreen(),
    );
  }
}
