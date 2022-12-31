import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/presentation/widgets/shimmers/rectangle_shimmer_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/constants/color_const.dart';
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
          height: 250.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                spreadRadius: 3,
                blurRadius: 4,
                color: Colors.grey.shade300,
                offset: const Offset(1, 3),
              ),
            ],
          ),
          child: Hero(
            tag: bookItem.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                  imageUrl: bookItem.image,
                  height: 200.h,
                  placeholder: (context, url) {
                    return RectangleShimmerItem(
                      height: 200.h,
                      width: 180.w,
                    );
                  }),
            ),
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
              color: ColorConst.blackWithOpacity063,
            ),
          ),
        ),
      ],
    );
  }

  final BookModel bookItem;
}
