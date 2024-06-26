import 'package:book_store/app/app_cubit/app_cubit.dart';
import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/data/models/status.dart';
import 'package:book_store/data/repositories/saved_book_repository.dart';
import 'package:book_store/presentation/utils/constants/route_names.dart';
import 'package:book_store/presentation/views/tab_box/tabs/saved/cubit/saved_book_cubit.dart';
import 'package:book_store/presentation/views/tab_box/tabs/saved/views/widgets/no_saved_book_item.dart';
import 'package:book_store/presentation/views/tab_box/tabs/saved/views/widgets/shimmer_saved_book_item.dart';
import 'package:book_store/presentation/widgets/buttons/custom_rectangle_text_button.dart';
import 'package:book_store/presentation/utils/constants/color_const.dart';
import 'package:book_store/presentation/utils/constants/poppins_font.dart';
import 'package:book_store/presentation/views/tab_box/tabs/saved/views/widgets/saved_book_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedBooksScreen extends StatelessWidget {
  const SavedBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var savedBookRepository = SavedBookRepository(
      firestore: FirebaseFirestore.instance,
    );
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        if (state.user == null) {
          return savedBooksShimmerList();
        }
        return BlocProvider(
          create: (context) => SavedBookCubit(
            savedBookRepository: savedBookRepository,
          )..getSavedBooks(userId: state.user!.uid),
          child: Scaffold(
            backgroundColor: ColorConst.white,
            body: Column(
              children: [
                Expanded(
                  child: BlocBuilder<SavedBookCubit, SavedBookState>(
                    builder: (context, state) {
                      if (state.status == Status.loading) {
                        return savedBooksShimmerList();
                      } else if (state.status == Status.success) {
                        if (state.savedBooks.isEmpty) {
                          return const NoSavedBookItem();
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
                                    style: PoppinsFont.w600,
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
                                      bookItem: BookModel.fromSavedBook(
                                          state.savedBooks[index]),
                                      onDeleteTap: () async {
                                        await savedBookRepository
                                            .deleteSavedBook(
                                                docId:
                                                    state.savedBooks[index].id);
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
      },
    );
  }

  Widget savedBooksShimmerList() => ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: 5,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
        itemBuilder: (context, index) {
          return const ShimmerSavedBookItem();
        },
      );
}
