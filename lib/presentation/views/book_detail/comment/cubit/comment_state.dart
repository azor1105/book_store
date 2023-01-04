part of 'comment_cubit.dart';

class CommentState extends Equatable {
  const CommentState({
    required this.userComments,
    this.status = Status.pure,
    this.error = '',
  });

  final Status status;
  final List<UserCommentModel> userComments;
  final String error;

  CommentState copyWith({
    Status? status,
    List<UserCommentModel>? userComments,
    String? error,
  }) =>
      CommentState(
        userComments: userComments ?? this.userComments,
        status: status ?? this.status,
        error: error ?? this.error,
      );

  @override
  List<Object> get props => [status, userComments, error];
}

class UserCommentModel {
  UserCommentModel({
    required this.commentModel,
    required this.userModel,
  });
  final CommentModel commentModel;
  final UserModel userModel;
}
