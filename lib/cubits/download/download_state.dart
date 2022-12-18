part of 'download_cubit.dart';

class DownloadState extends Equatable {
  const DownloadState({required this.downloadTasks});
  final List<DownloadTaskModel> downloadTasks;
  @override
  List<Object> get props => [downloadTasks];
}

class DownloadTaskModel {
  final double progress;
  final BookModel bookModel;

  DownloadTaskModel({
    required this.bookModel,
    this.progress = 0.0,
  });

  DownloadTaskModel copyWith({
    BookModel? bookModel,
    double? progress,
  }) {
    return DownloadTaskModel(
      bookModel: bookModel ?? this.bookModel,
      progress: progress ?? this.progress,
    );
  }
}
