import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/data/service/models/downloaded_book/downloaded_book_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/my_fonts.dart';

class BookDetailInfoItem extends StatelessWidget {
  const BookDetailInfoItem({
    super.key,
    this.bookItem,
    this.downloadedBookModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Language: ${downloadedBookModel?.language ?? bookItem!.language}",
          style: MyFonts.w400.copyWith(
            fontSize: 17.sp,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          "${downloadedBookModel?.pagesCount ?? bookItem!.pagesCount} pages",
          style: MyFonts.w400.copyWith(
            fontSize: 17.sp,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          "Published date: ${DateFormat.yMMMMd().format(
            DateTime.parse(
                downloadedBookModel?.publishedDate ?? bookItem!.publishedDate),
          )}",
          style: MyFonts.w400.copyWith(
            fontSize: 17.sp,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          "Genre: ${downloadedBookModel?.categoryName ??  bookItem!.categoryName}",
          style: MyFonts.w400.copyWith(
            fontSize: 17.sp,
          ),
        ),
      ],
    );
  }

  final BookModel? bookItem;
  final DownloadedBookModel? downloadedBookModel;
}
