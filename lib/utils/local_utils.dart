import 'dart:developer';
import 'dart:math' as math;
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import '../constants/constants_colors.dart';
import '../constants/constants_url.dart';

void showMessage(BuildContext context, {required String message}) async {
  try {
    Flushbar(
      backgroundColor: kFlushBarBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      flushbarPosition: FlushbarPosition.TOP,
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kWhiteColor,
          fontSize: 14,
        ),
      ),
      duration: const Duration(seconds: 2),
    ).show(context);
  } catch (e) {
    log('showMessage error : $e');
  }
}

String getVerificationCode() {
  String newVerificationCode = '';
  for (int i = 0; i < 6; i++) {
    newVerificationCode += math.Random().nextInt(10).toString();
  }
  return newVerificationCode;
}

Map<String, dynamic> getDefaultUserData() {
  DateTime nowDate = DateTime.now();
  Map<String, dynamic> data = {
    'name': '새이름입력',
    'profileImage':
        nowDate.second % 2 == 0 ? kProfileRedImageUrl : kProfileYellowImageUrl,
    'gender': '남',
  };
  return data;
}
