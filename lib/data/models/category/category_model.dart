import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable(explicitToJson: false)
class CategoryModel {
  @JsonKey(defaultValue: "", name: "category_img")
  String categoryImg;
  @JsonKey(defaultValue: "", name: "id")
  String id;
  @JsonKey(defaultValue: "", name: "category_name")
  String categoryName;

  CategoryModel({
    required this.categoryImg,
    required this.categoryName,
    required this.id,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
