import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/views/home/widgets/rectangle_shimmer_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/my_colors.dart';
import '../../../utils/my_fonts.dart';

class BookDetailItem extends StatelessWidget {
  const BookDetailItem({
    super.key,
    required this.bookItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                spreadRadius: 7,
                blurRadius: 7,
                color: Colors.grey.shade300,
                offset: const Offset(1, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: CachedNetworkImage(
                imageUrl: bookItem.image,
                height: 200,
                placeholder: (context, url) {
                  return const RectangleShimmerItem(
                    height: 200,
                    width: 200,
                  );
                }),
          ),
        ),
        SizedBox(height: 20.h),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Text(
              bookItem.bookName,
              style: MyFonts.w600,
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Center(
          child: Text(
            bookItem.authorName,
            style: MyFonts.w300.copyWith(
              fontSize: 21.sp,
              color: MyColors.blackWithOpacity063,
            ),
          ),
        ),
      ],
    );
  }

  final BookModel bookItem;
}
