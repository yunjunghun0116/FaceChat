import 'package:flutter/material.dart';

import '../../../../constants/constants_colors.dart';
import '../../../../constants/constants_value.dart';
import '../../../../utils/chat_utils.dart';

class ShowDateContainer extends StatelessWidget {
  final String? lastChatDate;
  final String chatDate;
  const ShowDateContainer({
    Key? key,
    this.lastChatDate,
    required this.chatDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (showDate(lastChatDate, chatDate)) {
      return Builder(
        builder: (context) {
          DateTime dateTime = DateTime.parse(chatDate);
          return Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              '${dateTime.year}년 ${dateTime.month}월 ${dateTime.day}일 ${kWeekdayList[dateTime.weekday - 1]}',
              style: TextStyle(
                fontSize: 13,
                height: 20 / 13,
                color: kFontGray500Color,
              ),
            ),
          );
        },
      );
    }
    return Container();
  }
}
