import 'package:book_store/data/service/models/downloaded_book/downloaded_book_model.dart';
import 'package:book_store/presentation/utils/constants/hive_constants.dart';
import 'package:hive/hive.dart';

class HiveService {
  Box<DownloadedBookModel> getBooks() =>
      Hive.box<DownloadedBookModel>(HiveConstants.downloadedBookBox);

  void addBook({required DownloadedBookModel downloadedBookModel}) {
    final downloadedBooksBox = getBooks();
    downloadedBooksBox.add(downloadedBookModel);
  }

  Future clearDownloadedBooksBox() async {
    final addressBox = getBooks();
    await addressBox.clear();
  }

  bool isExist({required String bookId}) {
    final downloadedBooksBox = getBooks();
    var books = downloadedBooksBox.values.toList();
    for (var book in books) {
      if (bookId == book.id) {
        return true;
      }
    }
    return false;
  }
}
