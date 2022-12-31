import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/presentation/widgets/shimmers/rectangle_shimmer_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants/color_const.dart';
import '../utils/constants/poppins_font.dart';

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
          color: ColorConst.white,
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
            Hero(
              tag: bookItem.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: bookItem.image,
                  height: 200.h,
                  width: 200.w,
                  placeholder: (context, url) {
                    return RectangleShimmerItem(
                      height: 200.h,
                      width: 200.w,
                      radius: 10.r,
                    );
                  },
                ),
              ),
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
                      style: PoppinsFont.w600.copyWith(
                        fontSize: 13.sp,
                        color: ColorConst.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      bookItem.authorName,
                      style: PoppinsFont.w500.copyWith(
                        fontSize: 12.sp,
                        color: ColorConst.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      bookItem.categoryName,
                      style: PoppinsFont.w500.copyWith(
                        fontSize: 12.sp,
                        color: ColorConst.blackWithOpacity087,
                      ),
                    ),
                    Text(
                      "${bookItem.pagesCount} pages",
                      style: PoppinsFont.w500.copyWith(
                        fontSize: 12.sp,
                        color: ColorConst.blackWithOpacity087,
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
