import 'package:book_store/data/models/book/book_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/saved_book/saved_book_model.dart';
import '../../../providers/saved_book_provider.dart';
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
    String userId = context.read<User?>()!.uid;
    return StreamBuilder<List<SavedBookModel>>(
      stream: context
          .read<SavedBookProvider>()
          .isExistBook(bookId: bookItem.id, userId: userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return IconButton(
              onPressed: () async {
                await context
                    .read<SavedBookProvider>()
                    .addBookToSavedBooks(userId: userId, bookId: bookItem.id);
              },
              icon: Image.asset(
                MyIcons.unselectedSaveIcon,
                height: 24,
                color: Colors.grey,
              ),
            );
          } else {
            return IconButton(
              onPressed: () async {
                await context
                    .read<SavedBookProvider>()
                    .deleteSavedBook(docId: snapshot.data![0].id);
              },
              icon: Image.asset(MyIcons.selectedSaveIcon,
                  height: 24, color: MyColors.c8687E7),
            );
          }
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Image.asset(
            MyIcons.unselectedSaveIcon,
            height: 24,
            color: Colors.grey,
          ),
        );
      },
    );
  }

  final BookModel bookItem;
  final String userId;
}
