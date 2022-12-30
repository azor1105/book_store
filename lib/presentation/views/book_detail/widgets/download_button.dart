import 'package:book_store/app/app_cubit/app_cubit.dart';
import 'package:book_store/cubits/downloaded_books/downloaded_books_cubit.dart';
import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/data/service/hive/hive_service.dart';
import 'package:book_store/presentation/utils/my_colors.dart';
import 'package:book_store/presentation/utils/my_fonts.dart';
import 'package:book_store/presentation/utils/utility_functions.dart';
import 'package:book_store/presentation/widgets/buttons/outlined_text_button.dart';
import 'package:book_store/presentation/widgets/buttons/text_button_with_background.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({super.key, required this.bookModel});
  final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadedBooksCubit, DownloadedBooksState>(
      builder: (context, state) {
        bool isDownloaded = HiveService.isExist(bookId: bookModel.id);
        var downloadTask = state.downloadTasks
            .where(
              (task) => task.bookModel.id == bookModel.id,
            )
            .toList();
        return Container(
          height: 50.h,
          width: 140.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: !isDownloaded
                ? [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(1, 3),
                      color: Colors.grey.shade300,
                    ),
                  ]
                : null,
          ),
          child: BlocBuilder<AppCubit, AppState>(
            buildWhen: (previous, current) {
              return previous.connectivityResult != current.connectivityResult; 
            },
            builder: (context, appState) {
              return TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor:
                        !isDownloaded ? MyColors.c8687E7 : Colors.grey.shade100,
                    backgroundColor:
                        !isDownloaded ? MyColors.white : Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    if (!isDownloaded && downloadTask.isEmpty) {
                      if (appState.connectivityResult ==
                          ConnectivityResult.none) {
                        MyUtils.getMyToast(
                            message: 'Please check internet connection');
                      } else {
                        context
                            .read<DownloadedBooksCubit>()
                            .downloadFile(bookModel: bookModel);
                      }
                    } else {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'Are you sure to delete this book?',
                            style: MyFonts.w500.copyWith(fontSize: 16.sp),
                          ),
                          actions: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: MyOutlinedButton(
                                      width: double.infinity,
                                      title: 'cancel',
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      height: 40.h,
                                    ),
                                  ),
                                  SizedBox(width: 20.w),
                                  Expanded(
                                    child: TextButtonWithBackground(
                                      height: 40.h,
                                      onPressed: () async {
                                        if (!isDownloaded &&
                                            downloadTask.isNotEmpty) {
                                          context
                                              .read<DownloadedBooksCubit>()
                                              .cancelDownloading(bookModel);
                                        } else {
                                          context
                                              .read<DownloadedBooksCubit>()
                                              .deleteBook(
                                                bookId: bookModel.id,
                                              );
                                        }
                                        Navigator.of(context).pop();
                                      },
                                      title: "delete",
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  child: downloadTask.isEmpty ||
                          downloadTask.isNotEmpty &&
                              downloadTask[0].progress == 100
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              !isDownloaded ? Icons.download : Icons.check,
                              color: MyColors.c8E7CFF,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              !isDownloaded ? 'Download' : 'Saved',
                              style: MyFonts.w400.copyWith(
                                fontSize: 14.sp,
                                color: MyColors.blackWithOpacity087,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Downloading %${downloadTask[0].progress.toStringAsFixed(0)}",
                              style: MyFonts.w400.copyWith(
                                fontSize: 14.sp,
                                color: MyColors.blackWithOpacity087,
                              ),
                            ),
                          ],
                        ));
            },
          ),
        );
      },
    );
  }
}
