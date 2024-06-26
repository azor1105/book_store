import 'package:book_store/data/models/book/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../utils/constants/poppins_font.dart';

class BookDetailInfoItem extends StatelessWidget {
  const BookDetailInfoItem({
    super.key,
    required this.bookItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Language: ${bookItem.language}",
          style: PoppinsFont.w400.copyWith(
            fontSize: 17.sp,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          "${bookItem.pagesCount} pages",
          style: PoppinsFont.w400.copyWith(
            fontSize: 17.sp,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          "Published date: ${DateFormat.yMMMMd().format(
            DateTime.parse(bookItem.publishedDate),
          )}",
          style: PoppinsFont.w400.copyWith(
            fontSize: 17.sp,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          "Genre: ${bookItem.categoryName}",
          style: PoppinsFont.w400.copyWith(
            fontSize: 17.sp,
          ),
        ),
      ],
    );
  }

  final BookModel bookItem;
}
