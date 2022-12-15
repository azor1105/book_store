import 'package:book_store/data/models/book/book_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/my_colors.dart';
import '../../../../../../utils/my_fonts.dart';

class SuggestionItem extends StatelessWidget {
  const SuggestionItem({
    super.key,
    required this.onSuggestionTap,
    required this.bookItem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSuggestionTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding:  EdgeInsets.all(15.sp),
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              spreadRadius: 5,
              blurRadius: 5,
              color: Colors.grey.shade300,
              offset: const Offset(1, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: CachedNetworkImage(
                imageUrl: bookItem.image,
                height: 90.h,
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: SizedBox(
                height: 90.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookItem.bookName,
                      maxLines: 2,
                      style: MyFonts.w400.copyWith(
                        fontSize: 14.sp,
                        color: MyColors.blackWithOpacity063,
                      ),
                    ),
                    Text(
                      bookItem.authorName,
                      style: MyFonts.w400.copyWith(
                        fontSize: 12.sp,
                        color: MyColors.blackWithOpacity063,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          bookItem.categoryName,
                          style: MyFonts.w400.copyWith(
                            fontSize: 12.sp,
                            color: MyColors.c8687E7,
                          ),
                        ),
                        Text(
                          "${bookItem.pagesCount} pages",
                          style: MyFonts.w400.copyWith(
                            fontSize: 12.sp,
                            color: MyColors.blackWithOpacity087,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  final BookModel bookItem;
  final VoidCallback onSuggestionTap;
}
