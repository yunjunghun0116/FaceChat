// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      senderId: json['senderId'] as String,
      message: json['message'],
      messageType: json['messageType'] as String,
      timeStamp: json['timeStamp'] as String,
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'senderId': instance.senderId,
      'message': instance.message,
      'messageType': instance.messageType,
      'timeStamp': instance.timeStamp,
    };
