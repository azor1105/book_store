import 'package:hive/hive.dart';

part 'saved_page_model.g.dart';

@HiveType(typeId: 1)
class SavedPageModel extends HiveObject {
  SavedPageModel({
    required this.bookId,
    required this.page,
  });

  @HiveField(0)
  String bookId;

  @HiveField(1)
  int page;
}