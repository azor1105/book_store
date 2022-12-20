import 'package:book_store/data/service/hive/models/downloaded_book/downloaded_book_model.dart';
import 'package:book_store/presentation/utils/constants/hive_constants.dart';
import 'package:hive/hive.dart';

class HiveService {
  static Box<DownloadedBookModel> getBooks() =>
      Hive.box<DownloadedBookModel>(HiveConstants.downloadedBookBox);

  static void addBook({required DownloadedBookModel downloadedBookModel}) {
    final downloadedBooksBox = getBooks();
    downloadedBooksBox.add(downloadedBookModel);
  }

  static Future clearDownloadedBooksBox() async {
    final addressBox = getBooks();
    await addressBox.clear();
  }

  static bool isExist({required String bookId}) {
    final downloadedBooksBox = getBooks();
    var books = downloadedBooksBox.values.toList();
    for (var book in books) {
      if (bookId == book.id) {
        return true;
      }
    }
    return false;
  }

  static DownloadedBookModel? getBookById({required String bookId}) {
    final downloadedBooksBox = getBooks();
    var books = downloadedBooksBox.values.toList();
    for (var book in books) {
      if (bookId == book.id) {
        return book;
      }
    }
    return null;
  }

  static String? getBookPath({required String bookId}) {
    final downloadedBooksBox = getBooks();
    var books = downloadedBooksBox.values.toList();
    for (var book in books) {
      if (bookId == book.id) {
        return book.bookPath;
      }
    }
    return null;
  }
}
