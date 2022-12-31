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
      authorId: json['author_id'] as String? ?? '',
      authorName: json['author_name'] as String? ?? '',
      bookName: json['book_name'] as String? ?? '',
      bookUrl: json['book_pdf'] as String? ?? '',
      categoryId: json['category_id'] as String? ?? '',
      categoryName: json['category_name'] as String? ?? '',
      description: json['book_description'] as String? ?? '',
      image: json['book_img'] as String? ?? '',
      language: json['book_language'] as String? ?? '',
      pagesCount: json['pages_count'] as int? ?? 0,
      publishedDate: json['published_date'] as String? ?? '',
    );

Map<String, dynamic> _$SavedBookModelToJson(SavedBookModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'book_id': instance.bookId,
      'user_id': instance.userId,
      'author_id': instance.authorId,
      'book_description': instance.description,
      'book_img': instance.image,
      'book_language': instance.language,
      'book_name': instance.bookName,
      'book_pdf': instance.bookUrl,
      'category_id': instance.categoryId,
      'pages_count': instance.pagesCount,
      'published_date': instance.publishedDate,
      'author_name': instance.authorName,
      'category_name': instance.categoryName,
    };
