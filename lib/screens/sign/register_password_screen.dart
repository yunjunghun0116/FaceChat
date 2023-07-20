import 'package:facechat/constants/constants_reg.dart';
import 'package:flutter/material.dart';

import '../../constants/constants_colors.dart';
import '../../widgets/custom_bottom_bar.dart';

class RegisterPasswordScreen extends StatefulWidget {
  final Function next;
  const RegisterPasswordScreen({Key? key, required this.next})
      : super(key: key);

  @override
  State<RegisterPasswordScreen> createState() => _RegisterPasswordScreenState();
}

class _RegisterPasswordScreenState extends State<RegisterPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController =
      TextEditingController();

  bool get canNextPress =>
      kPasswordRegExp.hasMatch(_passwordController.text) &&
      _passwordController.text.length >= 8 &&
      _passwordController.text == _passwordCheckController.text;

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
                  '가입정보 입력',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kFontGray900Color,
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 80,
                      child: Text('비밀번호'),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: kFontGray50Color,
                        ),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            isDense: true,
                            counterText: '',
                            hintText: '영문, 숫자 혼합 8자이상',
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
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const SizedBox(width: 80),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: kFontGray50Color,
                        ),
                        child: TextField(
                          controller: _passwordCheckController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            isDense: true,
                            counterText: '',
                            hintText: '다시 입력',
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
              ),
            ],
          ),
          bottomNavigationBar: CustomBottomBar(
            active: canNextPress,
            text: '다음',
            onTap: () => widget.next(_passwordController.text),
          )),
    );
  }
}
