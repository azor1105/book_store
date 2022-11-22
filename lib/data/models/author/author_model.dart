import 'package:json_annotation/json_annotation.dart';

part 'author_model.g.dart';

@JsonSerializable(explicitToJson: false)
class AuthorModel {
  @JsonKey(defaultValue: "", name: "author_img")
  String authorImg;
  @JsonKey(defaultValue: "", name: "author_name")
  String authorFullName;
  @JsonKey(defaultValue: "", name: "id")
  String id;

  AuthorModel({
    required this.authorFullName,
    required this.authorImg,
    required this.id,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) =>
      _$AuthorModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorModelToJson(this);
}
