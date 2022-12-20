import 'package:book_store/data/models/book/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookRepository {
  final FirebaseFirestore _fireStore;

  BookRepository({required FirebaseFirestore firestore}) : _fireStore = firestore;

  Stream<List<BookModel>> getAllBooks() =>
      _fireStore.collection('book').snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => BookModel.fromJson(doc.data()),
                )
                .toList(),
          );

  Stream<List<BookModel>> getBooksByAuhtorId({required String authorId}) {
    return _fireStore
        .collection('book')
        .where("author_id", isEqualTo: authorId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BookModel.fromJson(doc.data()))
              .toList(),
        );
  }

  Stream<List<BookModel>> getBooksByCategoryId({required String categoryId}) {
    return _fireStore
        .collection('book')
        .where("category_id", isEqualTo: categoryId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BookModel.fromJson(doc.data()))
              .toList(),
        );
  }

  Stream<BookModel> getBookById({required String bookId}) {
    return _fireStore
        .collection('book')
        .where("id", isEqualTo: bookId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BookModel.fromJson(doc.data()))
              .toList()[0],
        );
  }

  Future<BookModel> getBookByIdFuture({required String bookId}) async {
    var book = await _fireStore.collection("book").doc(bookId).get();

    return BookModel.fromJson(book.data() as Map<String, dynamic>);
  }

  Stream<List<BookModel>> getBooksBySearchText({required String searchText}) {
    return _fireStore.collection("book").snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => BookModel.fromJson(doc.data()))
              .toList()
              .where((element) =>
                  (element.bookName.toLowerCase()).contains(searchText))
              .toList(),
        );
  }
}
