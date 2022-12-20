// part of 'book_cubit.dart';

// class BookState extends Equatable {
//   const BookState({
//     this.status = Status.pure,
//     this.errorText = '',
//     required this.allBooks,
//   });

//   final Status status;
//   final List<BookModel> allBooks;
//   final List<BookModel> categoryBooks;
//   final List<BookModel> authorBooks;
//   final String errorText;

//   BookState copyWith({
//     Status? status,
//     List<BookModel>? allBooks,
//     String? errorText,
//   }) =>
//       BookState(
//         allBooks: allBooks ?? this.allBooks,
//         status: status ?? this.status,
//         errorText: errorText ?? this.errorText,
//       );

//   @override
//   List<Object> get props => [status, allBooks, errorText];
// }
