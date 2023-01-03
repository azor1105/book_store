import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable(explicitToJson: false)
class CommentModel {
  @JsonKey(defaultValue: "", name: "id")
  String id;

  @JsonKey(defaultValue: "", name: "createdAt")
  String createdAt;

  @JsonKey(defaultValue: "", name: "uid")
  String uid;

  @JsonKey(defaultValue: "", name: "message")
  String message;

  CommentModel({
    required this.createdAt,
    required this.id,
    required this.message,
    required this.uid,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}