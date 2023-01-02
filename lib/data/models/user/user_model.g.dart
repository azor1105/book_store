// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      fcmToken: json['fcmToken'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      password: json['password'] as String? ?? '',
      photoUrl: json['photoUrl'] as String? ?? '',
      uid: json['uid'] as String? ?? '',
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'fullName': instance.fullName,
      'fcmToken': instance.fcmToken,
      'photoUrl': instance.photoUrl,
      'password': instance.password,
    };
