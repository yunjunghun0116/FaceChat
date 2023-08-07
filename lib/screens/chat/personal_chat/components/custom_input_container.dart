import 'package:facechat/services/personal_chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/constants_colors.dart';

class CustomInputContainer extends StatefulWidget {
  final String chatId;
  final String userId;
  const CustomInputContainer({
    Key? key,
    required this.chatId,
    required this.userId,
  }) : super(key: key);

  @override
  State<CustomInputContainer> createState() => _CustomInputContainerState();
}

class _CustomInputContainerState extends State<CustomInputContainer> {
  final TextEditingController _textEditingController = TextEditingController();

  void sendText() {
    String text = _textEditingController.text;
    _textEditingController.clear();
    if (text.isEmpty) return;
    PersonalChatService()
        .sendText(chatId: widget.chatId, userId: widget.userId, text: text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhiteColor,
      child: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            border: Border.all(color: kDarkGray20Color),
            color: kDarkGray10Color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  style: TextStyle(
                    fontSize: 13,
                    color: kFontGray800Color,
                    height: 18 / 13,
                    letterSpacing: -0.5,
                  ),
                  maxLines: null,
                  decoration: const InputDecoration(
                    constraints: BoxConstraints(
                      minHeight: 42,
                      maxHeight: 100,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    counterText: '',
                  ),
                  onChanged: (text) => setState(() {}),
                ),
              ),
              const SizedBox(width: 16),
              SvgPicture.asset(
                'assets/icons/svg/camera_28px.svg',
              ),
              const SizedBox(width: 16),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => sendText(),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: _textEditingController.text.isNotEmpty
                        ? kMainColor
                        : kFontGray200Color,
                  ),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: SvgPicture.asset(
                      'assets/icons/svg/send_chat_24px.svg',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
            ],
          ),
        ),
      ),
    );
  }
}
