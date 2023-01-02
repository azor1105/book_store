import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: false)
class UserModel {
  @JsonKey(defaultValue: "", name: "uid")
  String uid;

  @JsonKey(defaultValue: "", name: "fullName")
  String fullName;

  @JsonKey(defaultValue: "", name: "fcmToken")
  String fcmToken;

  @JsonKey(defaultValue: "", name: "photoUrl")
  String photoUrl;

  @JsonKey(defaultValue: "", name: "password")
  String password;

  UserModel({
    required this.fcmToken,
    required this.fullName,
    required this.password,
    required this.photoUrl,
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}