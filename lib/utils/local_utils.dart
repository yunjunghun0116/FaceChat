import 'dart:developer';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import '../constants/constants_colors.dart';

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
