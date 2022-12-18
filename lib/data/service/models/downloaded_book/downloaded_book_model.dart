import 'package:book_store/data/models/book/book_model.dart';
import 'package:hive/hive.dart';

part 'downloaded_book_model.g.dart';

@HiveType(typeId: 0)
class DownloadedBookModel extends HiveObject {
  @HiveField(0)
  late BookModel bookModel;

  @HiveField(1)
  late String bookPath;
}
// flutter packages pub run build_runner build --delete-conflicting-outputs  