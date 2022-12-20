import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/data/service/hive/hive_service.dart';
import 'package:equatable/equatable.dart';

part 'downloaded_books_state.dart';

class DownloadedBooksCubit extends Cubit<DownloadedBooksState> {
  DownloadedBooksCubit() : super(const DownloadedBooksState(books: []));

  void getBooks() {
    var books = HiveService.getBooks()
        .values
        .map((downloadedBook) => downloadedBook.toBookModel())
        .toList();
    emit(DownloadedBooksState(books: books));
  }

  void deleteBook({required String bookId}) async {
    await HiveService.deleteBook(bookId: bookId);
    getBooks();
  }
}
