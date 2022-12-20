import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/data/models/author/author_model.dart';
import 'package:book_store/data/models/status.dart';
import 'package:book_store/data/repositories/author_repository.dart';
import 'package:equatable/equatable.dart';

part 'author_state.dart';

class AuthorCubit extends Cubit<AuthorState> {
  AuthorCubit({required AuthorRepository authorRepository})
      : _authorRepository = authorRepository,
        super(const AuthorState(authors: []));

  final AuthorRepository _authorRepository;
  late StreamSubscription<List<AuthorModel>> _streamSubscription;

  void getAuthors() {
    emit(state.copyWith(status: Status.loading));
    _streamSubscription = _authorRepository.getAllAuthors().listen(
      (authors) {
        emit(
          state.copyWith(
            authors: authors,
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
