import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/data/repositories/saved_book_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/models/saved_book/saved_book_model.dart';
import '../../../utils/constants/color_const.dart';
import '../../../utils/my_icons.dart';

class SaveBookButton extends StatelessWidget {
  const SaveBookButton({
    super.key,
    required this.bookModel,
    required this.userId,
    required this.connectivityResult,
  });

  @override
  Widget build(BuildContext context) {
    var savedBookRepository = SavedBookRepository(
      firestore: FirebaseFirestore.instance,
    );
    return connectivityResult == ConnectivityResult.none
        ? const SizedBox()
        : StreamBuilder<List<SavedBookModel>>(
            stream: savedBookRepository.isExistBook(
                bookId: bookModel.id, userId: userId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return IconButton(
                    onPressed: () async {
                      savedBookRepository.addBookToSavedBooks(
                          userId: userId, bookModel: bookModel);
                    },
                    icon: Image.asset(
                      MyIcons.unselectedSaveIcon,
                      height: 24.h,
                      color: Colors.grey,
                    ),
                  );
                } else {
                  return IconButton(
                    onPressed: () async {
                      savedBookRepository.deleteSavedBook(
                          docId: snapshot.data![0].id);
                    },
                    icon: Image.asset(
                      MyIcons.selectedSaveIcon,
                      height: 24.h,
                      color: ColorConst.c8687E7,
                    ),
                  );
                }
              }
              return IconButton(
                onPressed: () {},
                icon: Image.asset(
                  MyIcons.unselectedSaveIcon,
                  height: 24.h,
                  color: Colors.grey,
                ),
              );
            },
          );
  }

  final BookModel bookModel;
  final String userId;
  final ConnectivityResult connectivityResult;
}
