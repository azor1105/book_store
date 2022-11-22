import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/views/home/widgets/rectangle_shimmer_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/my_colors.dart';
import '../../../utils/my_fonts.dart';

class BookInfoItem extends StatelessWidget {
  const BookInfoItem({
    super.key,
    required this.bookItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(bottom: 5.h),
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              spreadRadius: 5,
              blurRadius: 5,
              color: Colors.grey.shade300,
              offset: const Offset(1, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                  width: 200,
                  fit: BoxFit.fill,
                  imageUrl: bookItem.image,
                  height: 200,
                  placeholder: (context, url) {
                    return const RectangleShimmerItem(
                      height: 200,
                      width: 200,
                    );
                  }),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookItem.bookName,
                      style: MyFonts.w600.copyWith(
                          fontSize: 13.sp,
                          color: MyColors.black,
                          overflow: TextOverflow.ellipsis),
                    ),

                    Text(
                      bookItem.authorName,
                      style: MyFonts.w500.copyWith(
                        fontSize: 12.sp,
                        color: MyColors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      bookItem.categoryName,
                      style: MyFonts.w500.copyWith(
                        fontSize: 12.sp,
                        color: MyColors.blackWithOpacity087,
                      ),
                    ),
                    Text(
                      "${bookItem.pagesCount} pages",
                      style: MyFonts.w500.copyWith(
                        fontSize: 12.sp,
                        color: MyColors.blackWithOpacity087,
                      ),
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

  final VoidCallback onTap;
  final BookModel bookItem;
}
