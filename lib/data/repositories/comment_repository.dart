import 'package:book_store/data/models/comment/comment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentRepository {
  CommentRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Stream<List<CommentModel>> getComments({required String bookId}) => _firestore
      .collection('comments')
      .where('bookId', isEqualTo: bookId)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map(
            (doc) => CommentModel.fromJson(doc.data()),
          )
          .toList());

  Future<void> addComment(CommentModel commentModel) async {
    var addedComment =
        await _firestore.collection('comments').add(commentModel.toJson());
    await addedComment.update({'id': addedComment.id});
  }

  Future<void> deleteComment({required String id}) async {
    await _firestore.collection('comments').doc(id).delete();
  }
}
