import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:facechat/constants/constants_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../utils/local_utils.dart';
import '../../widgets/custom_check_box.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _autoLogin = true;

  void kakaoSignIn() async {
    //TODO kakao developer -> 플랫폼 -> 키해시 수정(안드로이드) - 개발시 수정해야함
    try {
      if (await isKakaoTalkInstalled()) {
        await UserApi.instance.loginWithKakaoTalk();
      } else {
        await UserApi.instance.loginWithKakaoAccount();
      }
      User user = await UserApi.instance.me();
      String? userEmail = user.kakaoAccount?.email;
      if (userEmail == null) throw Exception('이메일이 존재하지 않습니다');
      if(!mounted) return;
      showMessage(context,message: '${userEmail} 카카오로그인 성공~');
    } catch (e) {
      log('kakaoSignIn Error : $e');
      return;
    }
  }

  void naverSignIn() async {
    try {
      NaverLoginResult result = await FlutterNaverLogin.logIn();
      if (result.status != NaverLoginStatus.loggedIn) {
        throw Exception('로그인을 실패했습니다');
      }
      if(!mounted) return;
      showMessage(context,message: '${result.account.email} 네이버로그인 성공~');
    } catch (e) {
      log('naverSignIn Error : $e');
      return;
    }
  }

  void appleSignIn() async {
    try {
      AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
      );
      if (credential.identityToken == null) {
        throw Exception('로그인을 실패했습니다');
      }
      List<String> jwt = credential.identityToken?.split('.') ?? [];
      //jwt는 header, payload, verify 로 나뉘어져있고, payload 에 데이터가 저장되어있음
      String payload = jwt[1];
      payload = base64.normalize(payload);

      final List<int> jsonData = base64.decode(payload);
      final userInfo = jsonDecode(utf8.decode(jsonData));
      String email = userInfo['email'];

      log(email);
    } catch (e) {
      log('appleSignIn Error : $e');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        children: [
          const SizedBox(height: 200),
          Center(child: Image.asset('assets/logo/face_chat_text_logo.png')),
          const SizedBox(height: 30),
          kCustomTextField(_emailController, '이메일'),
          const SizedBox(height: 10),
          kCustomTextField(_passwordController, '비밀번호'),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => setState(() => _autoLogin = !_autoLogin),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomCheckBox(
                    value: _autoLogin,
                    onTap: (value) => setState(() => _autoLogin = value),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '로그인 상태 유지',
                    style: TextStyle(
                      fontSize: 13,
                      color: kFontGray500Color,
                      height: 20 / 13,
                      letterSpacing: -0.5,
                    ),
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            height: 50,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: kMainColor,
            ),
            child: Text(
              '로그인',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kFontGray0Color,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              kCustomTextButton(onTap: () {}, text: '비밀번호 재설정'),
              kCustomTextButton(onTap: () {}, text: '회원가입'),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            'SNS로 간편 로그인',
            style: TextStyle(
              fontSize: 14,
              height: 20 / 14,
              color: kFontGray400Color,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kCustomSocialSignIn(
                onTap: () => kakaoSignIn(),
                image: 'assets/icons/social/kakao.png',
              ),
              const SizedBox(width: 10),
              kCustomSocialSignIn(
                onTap: () => naverSignIn(),
                image: 'assets/icons/social/naver.png',
              ),
              const SizedBox(width: 10),
              if (Platform.isIOS)
                kCustomSocialSignIn(
                  onTap: () => appleSignIn(),
                  image: 'assets/icons/social/apple.png',
                )
              else
                kCustomSocialSignIn(
                  onTap: () {},
                  image: 'assets/icons/social/google.jpg',
                ),
            ],
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget kCustomTextField(TextEditingController controller, String hintText) {
    return Container(
      width: double.infinity,
      height: 52,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: kFontGray50Color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          isDense: true,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            color: kFontGray400Color,
            height: 20 / 15,
          ),
        ),
        style: TextStyle(
          fontSize: 15,
          color: kFontGray400Color,
          height: 20 / 15,
        ),
      ),
    );
  }

  Widget kCustomTextButton({required Function onTap, required String text}) {
    return GestureDetector(
      onTap: () => onTap(),
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        width: 100,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            height: 20 / 12,
            letterSpacing: -0.5,
            color: kFontGray500Color,
          ),
        ),
      ),
    );
  }

  Widget kCustomSocialSignIn({required Function onTap, required String image}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: SizedBox(
        width: 44,
        height: 44,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Image.asset(
            image,
            width: 44,
            height: 44,
          ),
        ),
      ),
    );
  }
}
