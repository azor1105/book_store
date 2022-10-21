import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/views/home/widgets/rectangle_shimmer_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/my_colors.dart';
import '../../../utils/my_fonts.dart';

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
        width: 150,
        margin: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 4,
                    blurRadius: 4,
                    color: MyColors.blackWithOpacity044,
                    offset: const Offset(1, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CachedNetworkImage(
                    imageUrl: bookItem.image,
                    height: 200,
                    placeholder: (context, url) {
                      return const RectangleShimmerItem(
                        height: 200,
                        width: 150,
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
                    style: MyFonts.w600.copyWith(
                      fontSize: 13.sp,
                      color: MyColors.black,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    bookItem.authorName,
                    style: MyFonts.w400.copyWith(
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
