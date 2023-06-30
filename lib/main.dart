import 'package:facechat/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'constants/constants_colors.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: '7f56a7b5e87442ef9dc66fc1245f1313',
    javaScriptAppKey: 'd5f89ed414636be1a879c2187921759f',
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FaceChat',
      theme: ThemeData(
        fontFamily: 'AppleSDGothicNeo',
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: kFontGray400Color),
      ),
      builder: (context, child) {
        if (child == null) return Container();
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child,
        );
      },
      home: const SplashScreen(),
    );
  }
}
