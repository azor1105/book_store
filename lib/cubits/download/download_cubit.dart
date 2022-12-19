import 'package:bloc/bloc.dart';
import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/data/service/hive/hive_service.dart';
import 'package:book_store/data/service/models/downloaded_book/downloaded_book_model.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit({required Dio dio})
      : _dio = dio,
        super(DownloadState(downloadTasks: []));
  // Do not make const

  final Dio _dio;

  Future<void> downloadFile({required BookModel bookModel}) async {
    await Permission.storage.request();
    bool permissionStorage = await Permission.storage.request().isGranted;
    if (!permissionStorage) return;
    var documentDir = await getApplicationDocumentsDirectory();
    String path = '${documentDir.path}/${bookModel.id}.pdf';
    try {
      int maxPercent = 0;
      await _dio.download(bookModel.bookUrl, path,
          onReceiveProgress: (received, total) {
        double percent = received / total * 100;
        if (percent == 100) {
          HiveService.addBook(
            downloadedBookModel: DownloadedBookModel(
              authorId: bookModel.authorId,
              authorName: bookModel.authorName,
              bookName: bookModel.bookName,
              bookPath: path,
              bookPdfPath: bookModel.bookUrl,
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
        if (maxPercent < percent.toInt()) {
          var tasks = state.downloadTasks;
          tasks.removeWhere(
            (task) => task.bookModel.bookName == bookModel.bookName,
          );
          tasks.add(
            DownloadTaskModel(bookModel: bookModel, progress: percent),
          );
          maxPercent = percent.toInt();
          emit(DownloadState(downloadTasks: tasks));
        }
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
