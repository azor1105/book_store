import 'dart:io';
import 'package:book_store/data/local_data/local_data.dart';
import 'package:book_store/presentation/utils/constants/shared_pref_keys.dart';
import 'package:book_store/presentation/utils/utility_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository({required FirebaseAuth auth}) : _auth = auth;

  Future<void> signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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

  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Future<void> updateDisplayName({
    required BuildContext context,
    required String displayName,
  }) async {
    try {
      await _auth.currentUser!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Future<void> updateEmail({
    required BuildContext context,
    required String email,
  }) async {
    try {
      await _auth.currentUser!.updateEmail(email);
    } on FirebaseAuthException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  Future<void> updatePassword({
    required BuildContext context,
    required String password,
  }) async {
    try {
      await _auth.currentUser!.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      MyUtils.showSnackBar(context, e.message);
    }
  }

  User? get user => _auth.currentUser;

  Stream<User?> get authState => _auth.authStateChanges();

  Stream<User?> get userInfoChanges => _auth.userChanges();

  Future<void> uploadImage(
    XFile file
  ) async {
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
      await _auth.currentUser!.updatePhotoURL(downloadUrl);
    } on FirebaseException catch (error) {
      MyUtils.getMyToast(message: error.message.toString());
      throw Exception();
    }
  }
}
