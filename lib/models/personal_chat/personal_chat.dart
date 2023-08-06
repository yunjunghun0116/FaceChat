import 'package:json_annotation/json_annotation.dart';
part 'personal_chat.g.dart';

@JsonSerializable()
class PersonalChat {
  final String id;
  final List userIdList;

  PersonalChat({
    required this.id,
    required this.userIdList,
  });

  factory PersonalChat.fromJson(Map<String, dynamic> json) => _$PersonalChatFromJson(json);
  Map<String, dynamic> toJson() => _$PersonalChatToJson(this);
}
