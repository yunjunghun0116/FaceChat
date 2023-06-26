import 'package:facechat/screens/sign/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants_colors.dart';
import '../main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    playAnimation();
    signedUpCheck();
  }

  void playAnimation() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));

    _animation =
        Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(_animationController);

    Future.delayed(const Duration(milliseconds: 600),
        () => _animationController.forward());
  }

  void signedUpCheck() async {
    bool isSignedUp = false;
    if (!mounted) return;
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isSignedUp ? const MainScreen() : const LoginScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Stack(
        children: [
          SlideTransition(
            position: _animation,
            child: Center(
              child: Image.asset(
                'assets/logo/face_chat_text_logo.png',
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: kWhiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
