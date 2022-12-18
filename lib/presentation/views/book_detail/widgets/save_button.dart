import 'package:book_store/data/models/book/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/saved_book/saved_book_model.dart';
import '../../../../providers/saved_book_provider.dart';
import '../../../utils/my_colors.dart';
import '../../../utils/my_icons.dart';

class SaveBookButton extends StatelessWidget {
  const SaveBookButton({
    super.key,
    required this.bookItem,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SavedBookModel>>(
      stream: context
          .read<SavedBookProvider>()
          .isExistBook(bookId: bookItem.id, userId: userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return IconButton(
              onPressed: () async {
                context
                    .read<SavedBookProvider>()
                    .addBookToSavedBooks(userId: userId, bookId: bookItem.id);
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
                context
                    .read<SavedBookProvider>()
                    .deleteSavedBook(docId: snapshot.data![0].id);
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
          onPressed: (){},
          icon: Image.asset(
            MyIcons.unselectedSaveIcon,
            height: 24.h,
            color: Colors.grey,
          ),
        );
      },
    );
  }

  final BookModel bookItem;
  final String userId;
}
