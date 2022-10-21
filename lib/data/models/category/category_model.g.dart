// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      categoryImg: json['category_img'] as String? ?? '',
      categoryName: json['category_name'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'category_img': instance.categoryImg,
      'id': instance.id,
      'category_name': instance.categoryName,
    };
