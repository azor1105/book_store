part of 'author_cubit.dart';

class AuthorState extends Equatable {
  const AuthorState({
    required this.authors,
    this.errorText = '',
    this.status = Status.pure,
  });
  final Status status;
  final String errorText;
  final List<AuthorModel> authors;

  AuthorState copyWith({
    Status? status,
    String? errorText,
    List<AuthorModel>? authors,
  }) =>
      AuthorState(
        authors: authors ?? this.authors,
        errorText: errorText ?? this.errorText,
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [authors, status, errorText];
}
