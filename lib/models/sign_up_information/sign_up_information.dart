import 'package:json_annotation/json_annotation.dart';
part 'sign_up_information.g.dart';

@JsonSerializable()
class SignUpInformation {
  final String userId;
  final String apple;
  final String naver;
  final String kakao;
  final String google;
  final String email;
  final String password;

  SignUpInformation({
    required this.userId,
    required this.apple,
    required this.naver,
    required this.kakao,
    required this.google,
    required this.email,
    required this.password,
  });

  factory SignUpInformation.fromJson(Map<String, dynamic> json) =>
      _$SignUpInformationFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpInformationToJson(this);
}
