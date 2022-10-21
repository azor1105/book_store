import 'package:json_annotation/json_annotation.dart';

part 'saved_book_model.g.dart';

@JsonSerializable(explicitToJson: false)
class SavedBookModel {
  @JsonKey(defaultValue: "", name: "id")
  String id;

  @JsonKey(defaultValue: "", name: "book_id")
  String bookId;

  @JsonKey(defaultValue: "", name: "user_id")
  String userId;

  SavedBookModel({
    required this.bookId,
    required this.id,
    required this.userId,
  });

  factory SavedBookModel.fromJson(Map<String, dynamic> json) =>
      _$SavedBookModelFromJson(json);
  Map<String, dynamic> toJson() => _$SavedBookModelToJson(this);
}
