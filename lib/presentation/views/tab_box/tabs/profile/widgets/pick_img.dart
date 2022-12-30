import 'package:image_picker/image_picker.dart';

Future<XFile?> getFromGallery() async {
  final ImagePicker picker = ImagePicker();
  XFile? imageFile;
  imageFile = await picker.pickImage(
    maxHeight: 500,
    maxWidth: 700,
    source: ImageSource.gallery,
  );
  return imageFile;
}

Future<XFile?> getFromCamera() async {
  final ImagePicker picker = ImagePicker();
  XFile? imageFile;
  imageFile = await picker.pickImage(
    maxHeight: 500,
    maxWidth: 700,
    source: ImageSource.camera,
  );
  return imageFile;
}
