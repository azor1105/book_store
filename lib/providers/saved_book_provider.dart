import 'package:book_store/data/models/saved_book/saved_book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class SavedBookProvider {
  SavedBookProvider({required FirebaseFirestore firestore})
      : _fireStore = firestore;

  final FirebaseFirestore _fireStore;

  Stream<List<SavedBookModel>> isExistBook(
      {required String bookId, required String userId}) {
    return _fireStore
        .collection("saved_books")
        .where("book_id", isEqualTo: bookId)
        .where("user_id", isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => SavedBookModel.fromJson(doc.data()))
              .toList(),
        );
  }

  Future<void> addBookToSavedBooks(
      {required String userId, required String bookId}) async {
    var newSavedBook = await _fireStore.collection("saved_books").add(
          SavedBookModel(bookId: bookId, id: "", userId: userId).toJson(),
        );
    await _fireStore
        .collection("saved_books")
        .doc(newSavedBook.id)
        .update({"id": newSavedBook.id});
  }

  Future<void> deleteSavedBook({required String docId}) async {
    try {
      await _fireStore.collection("saved_books").doc(docId).delete();
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
  }


  Stream<List<SavedBookModel>> getAllSavedBooks({required String userId}) {
    return _fireStore
        .collection("saved_books")
        .where("user_id", isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((savedBook) => SavedBookModel.fromJson(savedBook.data()))
            .toList());
  }
}
