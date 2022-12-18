part of 'download_cubit.dart';

class DownloadState {
  const DownloadState({required this.downloadTasks});
  final List<DownloadTaskModel> downloadTasks;
}

class DownloadTaskModel {
  final double progress;
  final BookModel bookModel;

  DownloadTaskModel({
    required this.bookModel,
    this.progress = 0.0,
  });
}
