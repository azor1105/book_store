import 'package:book_store/data/models/category/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryRepository {
  CategoryRepository({required FirebaseFirestore firestore})
      : _fireStore = firestore;

  final FirebaseFirestore _fireStore;

  Stream<List<CategoryModel>> getAllCategories() =>
      _fireStore.collection('category').snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => CategoryModel.fromJson(doc.data()),
                )
                .toList(),
          );
}
