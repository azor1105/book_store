import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: false)
class UserModel {
  @JsonKey(defaultValue: "", name: "email")
  String email;

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

  @JsonKey(defaultValue: "", name: "docId")
  String docId;

  UserModel({
    required this.fcmToken,
    required this.fullName,
    required this.password,
    required this.photoUrl,
    required this.uid,
    required this.email,
    required this.docId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
