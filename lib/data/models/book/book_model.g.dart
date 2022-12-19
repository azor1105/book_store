// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) => BookModel(
      authorId: json['author_id'] as String? ?? '',
      bookName: json['book_name'] as String? ?? '',
      bookUrl: json['book_pdf'] as String? ?? '',
      categoryId: json['category_id'] as String? ?? '',
      description: json['book_description'] as String? ?? '',
      id: json['id'] as String? ?? '',
      image: json['book_img'] as String? ?? '',
      language: json['book_language'] as String? ?? '',
      pagesCount: json['pages_count'] as int? ?? 0,
      publishedDate: json['published_date'] as String? ?? '',
      authorName: json['author_name'] as String? ?? '',
      categoryName: json['category_name'] as String? ?? '',
    );

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'author_id': instance.authorId,
      'book_description': instance.description,
      'book_img': instance.image,
      'book_language': instance.language,
      'book_name': instance.bookName,
      'book_pdf': instance.bookUrl,
      'category_id': instance.categoryId,
      'id': instance.id,
      'pages_count': instance.pagesCount,
      'published_date': instance.publishedDate,
      'author_name': instance.authorName,
      'category_name': instance.categoryName,
    };
