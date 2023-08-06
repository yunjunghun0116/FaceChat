import 'package:json_annotation/json_annotation.dart';
part 'chat.g.dart';

@JsonSerializable()
class Chat {
  final String senderId;
  final dynamic message;
  final String messageType;
  final String timeStamp;

  Chat({
    required this.senderId,
    required this.message,
    required this.messageType,
    required this.timeStamp
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
