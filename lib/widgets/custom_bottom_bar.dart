import 'package:flutter/material.dart';

import '../constants/constants_colors.dart';

class CustomBottomBar extends StatelessWidget {
  final bool active;
  final Function onTap;
  final String text;
  const CustomBottomBar(
      {Key? key, required this.active, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!active) return;
        onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: active ? kMainColor : kFontGray100Color,
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 60,
            color: active ? kMainColor : kFontGray100Color,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 20 / 16,
                color: active ? kWhiteColor : kFontGray200Color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
