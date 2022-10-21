import 'package:json_annotation/json_annotation.dart';

part 'book_model.g.dart';

@JsonSerializable(explicitToJson: false)
class BookModel {
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
  String bookPdfPath;

  @JsonKey(defaultValue: "", name: "category_id")
  String categoryId;

  @JsonKey(defaultValue: "", name: "id")
  String id;

  @JsonKey(defaultValue: 0, name: "pages_count")
  int pagesCount;

  @JsonKey(defaultValue: "", name: "published_date")
  String publishedDate;

  @JsonKey(defaultValue: "", name: "author_name")
  String authorName;

  @JsonKey(defaultValue: "", name: "category_name")
  String categoryName;

  BookModel({
    required this.authorId,
    required this.bookName,
    required this.bookPdfPath,
    required this.categoryId,
    required this.description,
    required this.id,
    required this.image,
    required this.language,
    required this.pagesCount,
    required this.publishedDate,
    required this.authorName,
    required this.categoryName,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookModelToJson(this);
}
