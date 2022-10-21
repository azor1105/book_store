import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> getFromGallery(VoidCallback update) async {
  final ImagePicker picker = ImagePicker();
  XFile? imageFile;
  imageFile = await picker.pickImage(
    maxHeight: 500,
    maxWidth: 500,
    source: ImageSource.gallery,
  );
  return imageFile;
}

Future<XFile?> getFromCamera(VoidCallback update) async {
  final ImagePicker picker = ImagePicker();
  XFile? imageFile;
  imageFile = await picker.pickImage(
    maxHeight: 500,
    maxWidth: 500,
    source: ImageSource.camera,
  );
  return imageFile;
}
