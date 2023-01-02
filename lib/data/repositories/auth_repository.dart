import 'dart:io';
import 'package:book_store/data/local_data/local_data.dart';
import 'package:book_store/data/models/user/user_model.dart';
import 'package:book_store/presentation/utils/constants/shared_pref_keys.dart';
import 'package:book_store/presentation/utils/utility_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository(
      {required FirebaseAuth auth, required FirebaseFirestore firestore})
      : _auth = auth,
        _firestore = firestore;

  Future<void> signUp(
      {required String email,
      required String password,
      required String displayName,
      required BuildContext context}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = user!.uid;
      var addedUser = await _firestore.collection('users').add(
            UserModel(
              fcmToken: '',
              fullName: displayName,
              password: password,
              photoUrl: '',
              uid: uid,
              email: email,
              docId: '',
            ).toJson(),
          );
      await addedUser.update({'docId': addedUser.id});
    } on FirebaseAuthException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Future<void> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Future<void> deleteAccount({
    required BuildContext context,
    required String docId,
  }) async {
    try {
      await _auth.currentUser!.delete();
      await _firestore.collection('users').doc(docId).delete();
    } on FirebaseAuthException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Future<void> updateDisplayName({
    required BuildContext context,
    required String displayName,
    required String docId,
  }) async {
    try {
      await _firestore.collection('users').doc(docId).update(
        {'fullName': displayName},
      );
    } on FirebaseFirestore catch (e) {
      MyUtils.showSnackBar(context, e.toString());
    }
  }

  Future<void> updatePassword({
    required BuildContext context,
    required String password,
    required String docId,
  }) async {
    try {
      await _firestore.collection('users').doc(docId).update(
        {'password': password},
      );
      await _auth.currentUser!.updatePassword(password);
      signOut(context);
    } on FirebaseFirestore catch (e) {
      MyUtils.showSnackBar(context, e.toString());
    }
  }

  User? get user => _auth.currentUser;

  Stream<User?> get authState => _auth.authStateChanges();

  Stream<User?> get userInfoChanges => _auth.userChanges();

  Future<void> uploadImage({
    required XFile file,
    required String docId,
  }) async {
    try {
      //1- qadam eski rasmni ochirib tashlash
      String? userImgStorage = StorageRepository.getString(
          keyOfValue: SharedPrefKeys.userImgStorage);
      if (userImgStorage != null) {
        String storagePath = "users_img/$userImgStorage";
        await FirebaseStorage.instance.ref().child(storagePath).delete();
      }
      //2- qadam rasm yuklandi
      String storagePath = "users_img/${file.name}";
      var ref = FirebaseStorage.instance.ref().child(storagePath);
      var task = await ref.putFile(File(file.path));
      //3 -qadam rasm url get
      String downloadUrl = await task.ref.getDownloadURL();
      //4-qadam rasm url qaytaradi
      StorageRepository.putString(
        key: SharedPrefKeys.userImgStorage,
        value: file.name,
      );
      await _firestore.collection('users').doc(docId).update(
        {'photoUrl': downloadUrl},
      );
    } on FirebaseException catch (error) {
      MyUtils.getMyToast(message: error.message.toString());
      throw Exception();
    }
  }

  Stream<UserModel> fetchUser({required String uid}) => _firestore
      .collection('users')
      .where('uid', isEqualTo: uid)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map((doc) => UserModel.fromJson(doc.data()))
            .toList()[0],
      );
}
