// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      createdAt: json['createdAt'] as String? ?? '',
      id: json['id'] as String? ?? '',
      message: json['message'] as String? ?? '',
      userDocId: json['userDocId'] as String? ?? '',
      bookId: json['bookId'] as String? ?? '',
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'userDocId': instance.userDocId,
      'message': instance.message,
      'bookId': instance.bookId,
    };
