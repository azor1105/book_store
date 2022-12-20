// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:book_store/data/models/book/book_model.dart';
// import 'package:book_store/data/models/status.dart';
// import 'package:book_store/data/repositories/book_repository.dart';
// import 'package:equatable/equatable.dart';

// part 'book_state.dart';

// class BookCubit extends Cubit<BookState> {
//   BookCubit({required BookRepository bookRepository})
//       : _bookRepository = bookRepository,
//         super(const BookState(allBooks: []));

//   final BookRepository _bookRepository;
//   late StreamSubscription<List<BookModel>> _streamSubscription;



  // @override
  // Future<void> close() {
  //   _streamSubscription.cancel();
  //   return super.close();
  // }
// }
