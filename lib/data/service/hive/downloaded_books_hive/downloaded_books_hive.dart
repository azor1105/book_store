import 'dart:io';
import 'package:book_store/presentation/utils/constants/hive_constants.dart';
import 'package:hive/hive.dart';
import 'models/downloaded_book/downloaded_book_model.dart';

class DownloadedBooksHive {
  static Box<DownloadedBookModel> getBooks() =>
      Hive.box<DownloadedBookModel>(HiveConstants.downloadedBookBox);

  static DownloadedBookModel addBook(
      {required DownloadedBookModel downloadedBookModel}) {
    final downloadedBooksBox = getBooks();
    downloadedBooksBox.add(downloadedBookModel);
    return downloadedBookModel;
  }

  static Future clearDownloadedBooksBox() async {
    final downloadedBooksBox = getBooks();
    await downloadedBooksBox.clear();
  }

  static void updateAt(DownloadedBookModel downloadedBookModel) {
    final downloadedBooksBox = getBooks();
    for (int i = 0; i < downloadedBooksBox.values.length; i++) {
      if (downloadedBooksBox.values.toList()[i].id == downloadedBookModel.id) {
        downloadedBooksBox.putAt(i, downloadedBookModel);
      }
    }
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

  static Future<void> deleteBook({required String bookId}) async {
    var book = getBookById(bookId: bookId)!;
    try {
      File(book.bookPath).delete();
    } catch (e) {
      throw Exception(e);
    }
    book.delete();
  }
}
