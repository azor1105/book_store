import 'package:book_store/data/service/hive/saved_page_hive/models/saved_page_model.dart';
import 'package:book_store/presentation/utils/constants/hive_constants.dart';
import 'package:hive/hive.dart';

class SavedPageHive {
  static Box<SavedPageModel> getSavedPages() =>
      Hive.box<SavedPageModel>(HiveConstants.savedPageBox);

  static Future clearBox() async {
    final savedPagesBox = getSavedPages();
    await savedPagesBox.clear();
  }

  static void addPage(SavedPageModel savedPageModel) {
    final savedPagesBox = getSavedPages();
    for (int i = 0; i < savedPagesBox.values.length; i++) {
      if (savedPagesBox.values.toList()[i].bookId == savedPageModel.bookId) {
        savedPagesBox.putAt(i, savedPageModel);
        break;
      }
    }
    savedPagesBox.add(savedPageModel);
  }

  static SavedPageModel? getPage({required String bookId}) {
    final savedPagesBox = getSavedPages();
    var savedPages = savedPagesBox.values.toList();
    for (var savedPage in savedPages) {
      if (bookId == savedPage.bookId) {
        return savedPage;
      }
    }
    return null;
  }
}
