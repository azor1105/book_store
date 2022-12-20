import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/data/models/saved_book/saved_book_model.dart';
import 'package:book_store/data/models/status.dart';
import 'package:book_store/data/repositories/saved_book_repository.dart';
import 'package:equatable/equatable.dart';

part 'saved_book_state.dart';

class SavedBookCubit extends Cubit<SavedBookState> {
  SavedBookCubit({required SavedBookRepository savedBookRepository})
      : _savedBookRepository = savedBookRepository,
        super(const SavedBookState(savedBooks: []));

  final SavedBookRepository _savedBookRepository;
  late StreamSubscription<List<SavedBookModel>> _streamSubscription;

  void getSavedBooks({required String? userId}) {
    if (userId == null) {
      return;
    }
    emit(state.copyWith(status: Status.loading));
    _streamSubscription =
        _savedBookRepository.getAllSavedBooks(userId: userId).listen(
      (savedBooks) {
        emit(
          state.copyWith(
            savedBooks: savedBooks,
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
