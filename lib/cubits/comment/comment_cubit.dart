import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store/data/models/comment/comment_model.dart';
import 'package:book_store/data/models/status.dart';
import 'package:book_store/data/repositories/comment_repository.dart';
import 'package:equatable/equatable.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit({required CommentRepository commentRepository})
      : _commentRepository = commentRepository,
        super(const CommentState(comments: []));

  final CommentRepository _commentRepository;
  late StreamSubscription<List<CommentModel>> _streamSubscriptionComment;

  void getComments({required String bookId}) {
    emit(state.copyWith(status: Status.loading));
    _streamSubscriptionComment =
        _commentRepository.getComments(bookId: bookId).listen(
              (comments) => emit(state.copyWith(
                comments: comments,
                status: Status.success,
              )),
            );
  }

  @override
  Future<void> close() {
    _streamSubscriptionComment.cancel();
    return super.close();
  }
}
