import 'package:book_store/data/models/comment/comment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentRepository {
  CommentRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  // Stream<CommentModel> getComments(){}
}
