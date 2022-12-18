import 'package:book_store/data/service/models/downloaded_book/downloaded_book_model.dart';
import 'package:book_store/presentation/utils/constants/hive_constants.dart';
import 'package:hive/hive.dart';

class HiveService {
  Box<DownloadedBookModel> getBooks() =>
      Hive.box<DownloadedBookModel>(HiveConstants.downloadedBookBox);

  void addAddress({required DownloadedBookModel downloadedBookModel}) {
    final downloadedBooksBox = getBooks();
    downloadedBooksBox.add(downloadedBookModel);
  }

  Future clearDownloadedBooksBox() async {
    final addressBox = getBooks();
    await addressBox.clear();
  }
}
