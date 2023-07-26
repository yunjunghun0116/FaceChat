// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpInformation _$SignUpInformationFromJson(Map<String, dynamic> json) =>
    SignUpInformation(
      userId: json['userId'] as String,
      apple: json['apple'] as String,
      naver: json['naver'] as String,
      kakao: json['kakao'] as String,
      google: json['google'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignUpInformationToJson(SignUpInformation instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'apple': instance.apple,
      'naver': instance.naver,
      'kakao': instance.kakao,
      'google': instance.google,
      'email': instance.email,
      'password': instance.password,
    };
