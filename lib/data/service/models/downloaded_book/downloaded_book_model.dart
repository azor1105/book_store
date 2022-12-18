import 'package:book_store/data/models/book/book_model.dart';
import 'package:hive/hive.dart';

part 'downloaded_book_model.g.dart';

@HiveType(typeId: 0)
class DownloadedBookModel extends HiveObject {
  DownloadedBookModel({
    required this.authorId,
    required this.authorName,
    required this.bookName,
    required this.bookPath,
    required this.bookPdfPath,
    required this.categoryId,
    required this.categoryName,
    required this.description,
    required this.id,
    required this.image,
    required this.language,
    required this.pagesCount,
    required this.publishedDate,
  });
  @HiveField(0)
  String authorId;

  @HiveField(1)
  String description;

  @HiveField(2)
  String image;

  @HiveField(3)
  String language;

  @HiveField(4)
  String bookName;

  @HiveField(5)
  String bookPdfPath;

  @HiveField(6)
  String categoryId;

  @HiveField(7)
  String id;

  @HiveField(8)
  int pagesCount;

  @HiveField(9)
  String publishedDate;

  @HiveField(10)
  String authorName;

  @HiveField(11)
  String categoryName;

  @HiveField(12)
  String bookPath;
}
// flutter packages pub run build_runner build --delete-conflicting-outputs  