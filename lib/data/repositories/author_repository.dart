import 'package:book_store/data/models/author/author_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthorRepository {
  AuthorRepository({required FirebaseFirestore firebaseFirestore})
      : _fireStore = firebaseFirestore;

  final FirebaseFirestore _fireStore;

  Stream<List<AuthorModel>> getAllAuthors() =>
      _fireStore.collection('author').snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => AuthorModel.fromJson(doc.data()),
                )
                .toList(),
          );

}