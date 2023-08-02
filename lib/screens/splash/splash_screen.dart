import 'package:facechat/screens/sign/login_screen.dart';
import 'package:facechat/services/local_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/constants_colors.dart';
import '../../controllers/user_controller.dart';
import '../../models/user/user.dart';
import '../../services/firebase_user_service.dart';
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
    Future.delayed(const Duration(seconds: 3), () => signedUpCheck());
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
    String? userId = await LocalService.getUserId();

    if (userId != null) {
      User? user = await FirebaseUserService.getUser(userId: userId);
      if (!mounted) return;
      if (user != null) {
        context.read<UserController>().setUser(user);
        isSignedUp = true;
      }
    }
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            isSignedUp ? const MainScreen() : const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Stack(
        children: [
          SlideTransition(
            position: _animation,
            child: Center(
              child: Image.asset(
                'assets/logo/face_chat_white_text_logo.png',
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: kMainColor,
            ),
          ),
        ],
      ),
    );
  }
}
