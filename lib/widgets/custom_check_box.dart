import 'package:flutter/material.dart';

import '../constants/constants_colors.dart';

// 체크박스
class CustomCheckBox extends StatefulWidget {
  final bool value;
  final Function onTap;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;
  const CustomCheckBox({
    Key? key,
    required this.value,
    required this.onTap,
    required this.size,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(!widget.value),
      child: Container(
        alignment: Alignment.center,
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: kWhiteColor,
          border: Border.all(
            color: widget.value
                ? widget.activeColor ?? kMainColor
                : widget.inactiveColor ?? kFontGray200Color,
          ),
        ),
        child: widget.value
            ? Icon(
                Icons.check,
                color: widget.activeColor ?? kMainColor,
                size: widget.size - 4,
              )
            : null,
      ),
    );
  }
}
