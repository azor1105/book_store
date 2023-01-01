import 'package:bloc/bloc.dart';
import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/data/service/hive/downloaded_books_hive/downloaded_books_hive.dart';
import 'package:book_store/data/service/hive/downloaded_books_hive/models/downloaded_book/downloaded_book_model.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
part 'downloaded_books_state.dart';

class DownloadedBooksCubit extends Cubit<DownloadedBooksState> {
  DownloadedBooksCubit()
      : super(DownloadedBooksState(books: [], downloadTasks: []));

  CancelToken cancelToken = CancelToken();

  void getBooks() {
    var books = DownloadedBooksHive.getBooks()
        .values
        .map((downloadedBook) => downloadedBook.toBookModel())
        .toList();
    emit(state.copyWith(books: books));
  }

  void cancelDownloading(BookModel bookModel) {
    var tasks = state.downloadTasks;
    tasks.removeWhere(
      (task) => task.bookModel.bookName == bookModel.bookName,
    );
    cancelToken.cancel('Xato bermasngchi. Ha maylin sokish yozmiman.');
    cancelToken = CancelToken();
    emit(state.copyWith(downloadTasks: tasks));
  }

  void deleteBook({
    required String bookId,
  }) async {
    await DownloadedBooksHive.deleteBook(bookId: bookId);
    getBooks();
  }

  Future<void> downloadFile({required BookModel bookModel}) async {
    await Permission.storage.request();
    bool permissionStorage = await Permission.storage.request().isGranted;
    if (!permissionStorage) return;
    var documentDir = await getApplicationDocumentsDirectory();
    var tasks = state.downloadTasks;
    tasks.removeWhere(
      (task) => task.bookModel.bookName == bookModel.bookName,
    );
    tasks.add(DownloadTaskModel(bookModel: bookModel, progress: 0));
    emit(state.copyWith(downloadTasks: tasks));
    String path = '${documentDir.path}/${bookModel.id}.pdf';
    try {
      int maxPercent = 0;
      await Dio().download(bookModel.bookUrl, path, cancelToken: cancelToken,
          onReceiveProgress: (received, total) {
        double percent = received / total * 100;
        if (percent == 100) {
          DownloadedBooksHive.addBook(
            downloadedBookModel: DownloadedBookModel(
              authorId: bookModel.authorId,
              authorName: bookModel.authorName,
              bookName: bookModel.bookName,
              bookPath: path,
              bookUrl: bookModel.bookUrl,
              categoryId: bookModel.categoryId,
              categoryName: bookModel.categoryName,
              description: bookModel.description,
              id: bookModel.id,
              image: bookModel.image,
              language: bookModel.language,
              pagesCount: bookModel.pagesCount,
              publishedDate: bookModel.publishedDate,
            ),
          );
        }
        if (maxPercent < percent.floor()) {
          var tasks = state.downloadTasks;
          tasks.removeWhere(
            (task) => task.bookModel.bookName == bookModel.bookName,
          );
          tasks.add(
            DownloadTaskModel(bookModel: bookModel, progress: percent),
          );
          maxPercent = percent.toInt();
          emit(state.copyWith(downloadTasks: tasks));
        }
      });
      getBooks();
    } catch (e) {
      return;
    }
  }
}
