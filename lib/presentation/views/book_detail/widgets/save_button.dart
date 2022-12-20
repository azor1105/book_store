import 'package:book_store/cubits/connectivity/connectivity_cubit.dart';
import 'package:book_store/data/repositories/saved_book_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/models/saved_book/saved_book_model.dart';
import '../../../utils/my_colors.dart';
import '../../../utils/my_icons.dart';

class SaveBookButton extends StatelessWidget {
  const SaveBookButton({
    super.key,
    required this.bookId,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    var savedBookRepository = SavedBookRepository(
      firestore: FirebaseFirestore.instance,
    );
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      buildWhen: (previous, current) {
        return previous.connectivityResult != current.connectivityResult;
      },
      builder: (context, state) {
        if (state.connectivityResult == ConnectivityResult.none) {
          return const SizedBox();
        } else {
          return StreamBuilder<List<SavedBookModel>>(
            stream:
                savedBookRepository.isExistBook(bookId: bookId, userId: userId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return IconButton(
                    onPressed: () async {
                      savedBookRepository.addBookToSavedBooks(
                          userId: userId, bookId: bookId);
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
                      color: MyColors.c8687E7,
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
      },
    );
  }

  final String bookId;
  final String userId;
}
