import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/presentation/widgets/shimmers/rectangle_shimmer_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/constants/color_const.dart';
import '../../../../../utils/constants/poppins_font.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({
    super.key,
    required this.onTap,
    required this.bookItem,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150.w,
        margin: EdgeInsets.only(top: 25.h),
        child: Column(
          children: [
            Container(
              height: 200.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 3,
                    blurRadius: 3,
                    color: Colors.grey.shade300,
                    offset: const Offset(1, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CachedNetworkImage(
                    imageUrl: bookItem.image,
                    height: 200.h,
                    placeholder: (context, url) {
                      return RectangleShimmerItem(
                        height: 200.h,
                        width: 140.w,
                        radius: 10.r,
                      );
                    }),
              ),
            ),
            Visibility(
              visible: visible,
              child: Column(
                children: [
                  SizedBox(height: 15.h),
                  Text(
                    bookItem.bookName,
                    style: PoppinsFont.w600.copyWith(
                      fontSize: 13.sp,
                      color: ColorConst.black,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    bookItem.authorName,
                    style: PoppinsFont.w400.copyWith(
                      fontSize: 12.sp,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final BookModel bookItem;
  final bool visible;
  final VoidCallback onTap;
}
