import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/data/models/status.dart';
import 'package:book_store/data/repositories/book_repository.dart';
import 'package:equatable/equatable.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit({required BookRepository bookRepository})
      : _bookRepository = bookRepository,
        super(
          const BookState(allBooks: [], categoryBooks: [], authorBooks: []),
        );

  final BookRepository _bookRepository;
  late StreamSubscription<List<BookModel>> _streamSubscription;

  void getBooks() {
    emit(state.copyWith(status: Status.loading));
    _streamSubscription = _bookRepository.getAllBooks().listen(
      (books) {
        emit(
          state.copyWith(
            allBooks: books,
            status: Status.success,
          ),
        );
      },
      onError: (error) {
        emit(
          state.copyWith(
            status: Status.error,
            errorText: error.toString(),
          ),
        );
      },
    );
  }

  void getCategoryBooks({required String categoryId}) {
    emit(state.copyWith(status: Status.loading, categoryBooks: []));
    _streamSubscription =
        _bookRepository.getBooksByCategoryId(categoryId: categoryId).listen(
      (books) {
        emit(
          state.copyWith(
            categoryBooks: books,
            status: Status.success,
          ),
        );
      },
      onError: (error) {
        emit(
          state.copyWith(
            status: Status.error,
            errorText: error.toString(),
          ),
        );
      },
    );
  }

  void getAuthorBooks({required String authorId}) {
    emit(state.copyWith(status: Status.loading, authorBooks: []));
    _streamSubscription =
        _bookRepository.getBooksByAuhtorId(authorId: authorId).listen(
      (books) {
        emit(
          state.copyWith(
            authorBooks: books,
            status: Status.success,
          ),
        );
      },
      onError: (error) {
        emit(
          state.copyWith(
            status: Status.error,
            errorText: error.toString(),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
