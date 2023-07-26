import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String name;
  final String profileImage;
  final String gender;
  final String signUpDate;

  User({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.gender,
    required this.signUpDate,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
