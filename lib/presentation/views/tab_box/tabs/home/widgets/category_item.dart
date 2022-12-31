import 'package:book_store/data/models/category/category_model.dart';
import 'package:book_store/presentation/widgets/shimmers/rectangle_shimmer_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/constants/color_const.dart';
import '../../../../../utils/my_fonts.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    required this.onTap,
    super.key,
    required this.categoryItem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150.h,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: ColorConst.cE5E5E5,
        ),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: categoryItem.categoryImg,
              height: 115.h,
              placeholder: (context, url) {
                return RectangleShimmerItem(
                  height: 115.h,
                  width: 120.w,
                );
              },
            ),
            SizedBox(width: 10.w),
            SizedBox(
              width: 80.w,
              child: Text(
                categoryItem.categoryName,
                style: MyFonts.w600.copyWith(
                  fontSize: 14.sp,
                  color: ColorConst.blackWithOpacity087,
                ),
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final VoidCallback onTap;
  final CategoryModel categoryItem;
}
