part of 'downloaded_books_cubit.dart';

class DownloadedBooksState extends Equatable {
  const DownloadedBooksState({required this.books});
  final List<BookModel> books;

  @override
  List<Object> get props => [books];
}
