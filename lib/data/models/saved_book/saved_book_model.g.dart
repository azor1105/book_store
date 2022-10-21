// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedBookModel _$SavedBookModelFromJson(Map<String, dynamic> json) =>
    SavedBookModel(
      bookId: json['book_id'] as String? ?? '',
      id: json['id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
    );

Map<String, dynamic> _$SavedBookModelToJson(SavedBookModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'book_id': instance.bookId,
      'user_id': instance.userId,
    };
