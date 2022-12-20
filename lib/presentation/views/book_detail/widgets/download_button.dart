import 'package:book_store/cubits/download/download_cubit.dart';
import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/data/service/hive/hive_service.dart';
import 'package:book_store/presentation/utils/my_colors.dart';
import 'package:book_store/presentation/utils/my_fonts.dart';
import 'package:book_store/presentation/utils/utility_functions.dart';
import 'package:book_store/presentation/widgets/buttons/outlined_text_button.dart';
import 'package:book_store/presentation/widgets/buttons/text_button_with_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DownloadButton extends StatefulWidget {
  const DownloadButton({super.key, required this.bookModel});

  @override
  State<DownloadButton> createState() => _DownloadButtonState();

  final BookModel bookModel;
}

class _DownloadButtonState extends State<DownloadButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadCubit, DownloadState>(
      builder: (context, state) {
        bool isDownloaded = HiveService.isExist(bookId: widget.bookModel.id);
        var downloadTask = state.downloadTasks
            .where(
              (task) => task.bookModel.id == widget.bookModel.id,
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
          child: TextButton(
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
                if (!isDownloaded) {
                  MyUtils.getMyToast(message: 'Downloading started');
                  context
                      .read<DownloadCubit>()
                      .downloadFile(bookModel: widget.bookModel);
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
                        Row(
                          children: [
                            Expanded(
                              child: MyOutlinedButton(
                                width: double.infinity,
                                title: Text(
                                  "cancel",
                                  style: MyFonts.w400
                                      .copyWith(color: MyColors.c8687E7),
                                ),
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
                                  HiveService.deleteBook(
                                      bookId: widget.bookModel.id);
                                  Navigator.of(context).pop();
                                  setState(() {});
                                },
                                title: "delete",
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }
              },
              child: downloadTask.isEmpty ||
                      downloadTask.isNotEmpty && downloadTask[0].progress == 100
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
                    )),
        );
      },
    );
  }
}
