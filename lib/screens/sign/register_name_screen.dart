import 'package:flutter/material.dart';

import '../../constants/constants_colors.dart';
import '../../constants/constants_url.dart';
import '../../widgets/custom_bottom_bar.dart';

class RegisterNameScreen extends StatefulWidget {
  final Function next;
  const RegisterNameScreen({Key? key, required this.next}) : super(key: key);

  @override
  State<RegisterNameScreen> createState() => _RegisterNameScreenState();
}

class _RegisterNameScreenState extends State<RegisterNameScreen> {
  final TextEditingController _nameController = TextEditingController();

  late String _profileImage;

  bool get canNextPress => _nameController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _profileImage = DateTime.now().second % 2 == 0
        ? kProfileRedImageUrl
        : kProfileYellowImageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '프로필 설정',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kFontGray900Color,
                  height: 1,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '프로필은 언제든 변경할 수 있어요.',
                style: TextStyle(
                  fontSize: 14,
                  color: kFontGray500Color,
                  height: 20 / 14,
                ),
              ),
            ),
            const SizedBox(height: 36),
            Center(
              child: Container(
                width: 104,
                height: 104,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(104),
                    color: kSubColor1,
                    image: DecorationImage(
                        image: NetworkImage(
                      _profileImage,
                    ))),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                width: 140,
                height: 52,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: kFontGray100Color,
                      width: 1.5,
                    ),
                  ),
                ),
                child: TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 8,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    isDense: true,
                    counterText: '',
                    hintText: '8자 이내 닉네임',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: kFontGray400Color,
                      height: 20 / 14,
                    ),
                  ),
                  onChanged: (text) => setState(() {}),
                  style: TextStyle(
                    fontSize: 14,
                    color: kFontGray800Color,
                    height: 20 / 14,
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomBar(
          active: canNextPress,
          text: '완료',
          onTap: () => widget.next(_nameController.text, _profileImage),
        ),
      ),
    );
  }
}
