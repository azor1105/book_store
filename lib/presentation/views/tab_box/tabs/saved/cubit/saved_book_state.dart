part of 'saved_book_cubit.dart';

class SavedBookState extends Equatable {
  const SavedBookState({
    required this.savedBooks,
    this.errorText = '',
    this.status = Status.pure,
  });
  final Status status;
  final String errorText;
  final List<SavedBookModel> savedBooks;

  SavedBookState copyWith({
    Status? status,
    String? errorText,
    List<SavedBookModel>? savedBooks,
  }) =>
      SavedBookState(
        savedBooks: savedBooks ?? this.savedBooks,
        errorText: errorText ?? this.errorText,
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [savedBooks, status, errorText];
}
