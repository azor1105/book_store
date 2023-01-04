import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_store/data/models/comment/comment_model.dart';
import 'package:book_store/data/models/status.dart';
import 'package:book_store/data/models/user/user_model.dart';
import 'package:book_store/data/repositories/comment_repository.dart';
import 'package:equatable/equatable.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit({required CommentRepository commentRepository})
      : _commentRepository = commentRepository,
        super(const CommentState(userComments: []));

  final CommentRepository _commentRepository;
  late StreamSubscription<List<CommentModel>> _streamSubscriptionComment;

  void getComments({required String bookId}) async {
    emit(state.copyWith(status: Status.loading));
    var users = await _commentRepository.getUsers();
    _streamSubscriptionComment =
        _commentRepository.getComments(bookId: bookId).listen(
      (comments) {
        List<UserCommentModel> userComments = [];
        for (var comment in comments) {
          userComments.add(
            UserCommentModel(
                commentModel: comment,
                userModel: users
                    .where((user) => user.docId == comment.userDocId)
                    .toList()[0]),
          );
        }
        emit(state.copyWith(
          userComments: userComments,
          status: Status.success,
        ));
      },
    );
  }

  @override
  Future<void> close() {
    _streamSubscriptionComment.cancel();
    return super.close();
  }
}
