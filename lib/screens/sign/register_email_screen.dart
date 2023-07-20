import 'package:facechat/services/http_service.dart';
import 'package:flutter/material.dart';
import '../../constants/constants_colors.dart';
import '../../constants/constants_reg.dart';
import '../../utils/local_utils.dart';
import '../../widgets/custom_bottom_bar.dart';

class RegisterEmailScreen extends StatefulWidget {
  final Function next;
  const RegisterEmailScreen({Key? key, required this.next}) : super(key: key);

  @override
  State<RegisterEmailScreen> createState() => _RegisterEmailScreenState();
}

class _RegisterEmailScreenState extends State<RegisterEmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _certifyController = TextEditingController();

  bool _sendEmail = false;

  late String _verificationCode;

  bool get canSendEmailPress =>
      kEmailRegExp.hasMatch(_emailController.text) && !_sendEmail;
  bool get canNextPress =>
      _certifyController.text.length == 6 &&
      _certifyController.text == _verificationCode;

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
                    child: Text('이메일'),
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
                        enabled: !_sendEmail,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isDense: true,
                          counterText: '',
                          hintText: 'ex) example@facechat.kr',
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
            const SizedBox(height: 28),
            if (_sendEmail)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 80,
                      child: Text('인증번호'),
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
                          controller: _certifyController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            isDense: true,
                            counterText: '',
                            hintText: 'ex) 123456',
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
        bottomNavigationBar: _sendEmail
            ? CustomBottomBar(
                active: canNextPress,
                text: '다음',
                onTap: () {
                  //if 가입된 계정일 경우 안내메시지 보내고 초기화
                  //아니면 다음 화면으로 바꿈
                  widget.next(_emailController.text);
                },
              )
            : CustomBottomBar(
                active: canSendEmailPress,
                text: '인증번호 보내기',
                onTap: () {
                  String verificationCode = getVerificationCode();
                  setState(() {
                    _sendEmail = true;
                    _verificationCode = verificationCode;
                  });
                  HttpService.sendEmail(
                    email: _emailController.text,
                    verificationCode: verificationCode,
                  );
                },
              ),
      ),
    );
  }
}
