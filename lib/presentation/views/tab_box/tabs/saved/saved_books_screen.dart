import 'package:book_store/cubits/saved_book/saved_book_cubit.dart';
import 'package:book_store/data/models/status.dart';
import 'package:book_store/data/repositories/saved_book_repository.dart';
import 'package:book_store/presentation/utils/constants/route_names.dart';
import 'package:book_store/presentation/widgets/buttons/custom_rectangle_text_button.dart';
import 'package:book_store/presentation/utils/my_colors.dart';
import 'package:book_store/presentation/utils/my_fonts.dart';
import 'package:book_store/presentation/widgets/no_books_item.dart';
import 'package:book_store/presentation/views/tab_box/tabs/saved/widgets/saved_book_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SavedBooksScreen extends StatelessWidget {
  const SavedBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var savedBookRepository = SavedBookRepository(
      firestore: FirebaseFirestore.instance,
    );
    return BlocProvider(
      create: (context) => SavedBookCubit(
        savedBookRepository: savedBookRepository,
      )..getSavedBooks(userId: Provider.of<User?>(context, listen: false)!.uid),
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<SavedBookCubit, SavedBookState>(
                buildWhen: (previous, current) {
                  return previous.savedBooks.length !=
                      current.savedBooks.length;
                },
                builder: (context, state) {
                  if (state.status == Status.loading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state.status == Status.success) {
                    if (state.savedBooks.isEmpty) {
                      return const NoBookItem();
                    } else {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: Text(
                                "${state.savedBooks.length} ${state.savedBooks.length > 1 ? "books" : "book"}",
                                style: MyFonts.w600,
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: state.savedBooks.length,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 15.w),
                              itemBuilder: (context, index) {
                                return SavedBookItem(
                                  bookId: state.savedBooks[index].bookId,
                                  onDeleteTap: () async {
                                    await savedBookRepository.deleteSavedBook(
                                        docId: state.savedBooks[index].id);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  }
                  return const SizedBox();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: CustomRectangleTextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.downloadedBooks);
                },
                title: 'Read downloaded books',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
