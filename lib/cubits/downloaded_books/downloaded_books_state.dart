part of 'downloaded_books_cubit.dart';

class DownloadedBooksState {
  const DownloadedBooksState({
    required this.books,
    required this.downloadTasks,
  });

  final List<BookModel> books;
  final List<DownloadTaskModel> downloadTasks;

  DownloadedBooksState copyWith({
    List<BookModel>? books,
    List<DownloadTaskModel>? downloadTasks,
    bool? stopDowloading,
  }) {
    return DownloadedBooksState(
      books: books ?? this.books,
      downloadTasks: downloadTasks ?? this.downloadTasks,
    );
  }
}

class DownloadTaskModel {
  final double progress;
  final BookModel bookModel;

  DownloadTaskModel({
    required this.bookModel,
    this.progress = 0.0,
  });
}
