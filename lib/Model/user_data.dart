import 'package:json_annotation/json_annotation.dart';

part 'M_User.g.dart';

@JsonSerializable()
class M_User {
  String id;
  String f_name;
  String l_name;
  String username;
  String email;

  M_User(
      {required this.id,
      required this.f_name,
      required this.l_name,
      required this.username,
      required this.email});

  factory M_User.fromJson(Map<String, dynamic> json) => _$M_UserFromJson(json);

  Map<String, dynamic> toJson() => _$M_UserToJson(this);
}
