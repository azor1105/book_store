import 'package:book_store/data/models/comment/comment_model.dart';
import 'package:book_store/data/models/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentRepository {
  CommentRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Stream<List<CommentModel>> getComments({required String bookId}) => _firestore
      .collection('comments')
      .doc(bookId)
      .collection(bookId)
      .orderBy('createdAt')
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map(
              (doc) => CommentModel.fromJson(json: doc.data(), docId: doc.id),
            )
            .toList(),
      );
  Future<void> addComment(
      {required CommentModel commentModel, required String bookId}) async {
    await _firestore.collection('comments').doc(bookId).collection(bookId).add(
          commentModel.toJson(),
        );
  }

  Future<void> deleteComment({
    required String id,
    required String bookId,
  }) async {
    await _firestore
        .collection('comments')
        .doc(bookId)
        .collection(bookId)
        .doc(id)
        .delete();
  }

  Future<void> editComment({
    required String message,
    required String docId,
    required String bookId,
  }) async {
    await _firestore
        .collection('comments')
        .doc(bookId)
        .collection(bookId)
        .doc(docId)
        .update({'message': message});
  }

  Future<List<UserModel>> getUsers() async {
    var user = await _firestore.collection('users').get();
    return user.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }
}
