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

  @JsonKey(defaultValue: "", name: "author_id")
  String authorId;

  @JsonKey(defaultValue: "", name: "book_description")
  String description;

  @JsonKey(defaultValue: "", name: "book_img")
  String image;

  @JsonKey(defaultValue: "", name: "book_language")
  String language;

  @JsonKey(defaultValue: "", name: "book_name")
  String bookName;

  @JsonKey(defaultValue: "", name: "book_pdf")
  String bookUrl;

  @JsonKey(defaultValue: "", name: "category_id")
  String categoryId;

  @JsonKey(defaultValue: 0, name: "pages_count")
  int pagesCount;

  @JsonKey(defaultValue: "", name: "published_date")
  String publishedDate;

  @JsonKey(defaultValue: "", name: "author_name")
  String authorName;

  @JsonKey(defaultValue: "", name: "category_name")
  String categoryName;

  SavedBookModel({
    required this.bookId,
    required this.id,
    required this.userId,
    required this.authorId,
    required this.authorName,
    required this.bookName,
    required this.bookUrl,
    required this.categoryId,
    required this.categoryName,
    required this.description,
    required this.image,
    required this.language,
    required this.pagesCount,
    required this.publishedDate,
  });

  factory SavedBookModel.fromJson(Map<String, dynamic> json) =>
      _$SavedBookModelFromJson(json);
  Map<String, dynamic> toJson() => _$SavedBookModelToJson(this);
}
