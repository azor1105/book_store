// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorModel _$AuthorModelFromJson(Map<String, dynamic> json) => AuthorModel(
      authorFullName: json['author_name'] as String? ?? '',
      authorImg: json['author_img'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$AuthorModelToJson(AuthorModel instance) =>
    <String, dynamic>{
      'author_img': instance.authorImg,
      'author_name': instance.authorFullName,
      'id': instance.id,
    };
