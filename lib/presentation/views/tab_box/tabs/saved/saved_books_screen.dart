import 'package:book_store/data/models/saved_book/saved_book_model.dart';
import 'package:book_store/presentation/utils/constants/route_names.dart';
import 'package:book_store/providers/saved_book_provider.dart';
import 'package:book_store/presentation/utils/my_colors.dart';
import 'package:book_store/presentation/utils/my_fonts.dart';
import 'package:book_store/presentation/widgets/no_books_item.dart';
import 'package:book_store/presentation/views/tab_box/tabs/saved/widgets/saved_book_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SavedBooksScreen extends StatelessWidget {
  const SavedBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15.sp),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 3,
                  blurRadius: 3,
                  color: Colors.grey.shade300,
                  offset: const Offset(1, 3),
                ),
              ],
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  foregroundColor: MyColors.c8687E7,
                  backgroundColor: MyColors.white),
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.downloadedBooks);
              },
              child: Row(
                children: [
                  const Icon(Icons.check),
                  SizedBox(width: 20.w),
                  Text(
                    'Read downloaded books',
                    style: MyFonts.w500.copyWith(fontSize: 18.sp),
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder<List<SavedBookModel>>(
            stream: context.read<SavedBookProvider>().getAllSavedBooks(
                  userId: context.read<User?>()!.uid,
                ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<SavedBookModel> savedBooks = snapshot.data!;
                if (savedBooks.isEmpty) {
                  return const Expanded(child: NoBookItem());
                } else {
                  return Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Text(
                              "${savedBooks.length} ${savedBooks.length > 1 ? "books" : "book"}",
                              style: MyFonts.w600,
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: savedBooks.length,
                            padding: EdgeInsets.symmetric(
                                vertical: 20.h, horizontal: 15.w),
                            itemBuilder: (context, index) {
                              return SavedBookItem(
                                bookId: savedBooks[index].bookId,
                                onDeleteTap: () async {
                                  await context
                                      .read<SavedBookProvider>()
                                      .deleteSavedBook(
                                          docId: savedBooks[index].id);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
