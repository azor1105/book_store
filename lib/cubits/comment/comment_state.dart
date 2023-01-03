part of 'comment_cubit.dart';

class CommentState extends Equatable {
  const CommentState({
    required this.comments,
    this.status = Status.pure,
    this.error = '',
  });

  final Status status;
  final List<CommentModel> comments;
  final String error;

  CommentState copyWith({
    Status? status,
    List<CommentModel>? comments,
    String? error,
  }) =>
      CommentState(
        comments: comments ?? this.comments,
        status: status ?? this.status,
        error: error ?? this.error,
      );

  @override
  List<Object> get props => [status, comments, error];
}
