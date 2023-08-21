import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class HttpService {
  static final HttpService _instance = HttpService._internal();
  factory HttpService() => _instance;
  HttpService._internal();

  static Future<void> sendEmail({
    required String email,
    required String verificationCode,
  }) async {
    try {
      Map<String, dynamic> data = {
        'service_id': 'service_kbwouod',
        'template_id': 'template_5hgku89',
        'user_id': 'UB1SvQLjvQV50-rvG',
        'template_params': {
          'email': email,
          'message': verificationCode,
        }
      };
      http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(data),
      );

      log('$email 로 전송한 인증번호 : $verificationCode');
    } catch (e) {
      log('sendEmail Error : $e');
    }
  }

  static Future<String?> getRTCToken({
    required String channel,
  }) async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://us-central1-facechat-486a3.cloudfunctions.net/getRTCToken?channel=$channel&uid=0&role=publisher&tokentype=uid'));
      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body);
        String rtcToken = result['rtcToken'];
        return rtcToken;
      }

      return null;
    } catch (e) {
      log('getRTCToken Error : $e');
      return null;
    }
  }
}
