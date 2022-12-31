import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/presentation/utils/constants/route_names.dart';
import 'package:book_store/presentation/widgets/shimmers/rectangle_shimmer_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../utils/constants/color_const.dart';
import '../../../../../utils/constants/poppins_font.dart';
import '../../../../../utils/my_icons.dart';

class SavedBookItem extends StatelessWidget {
  const SavedBookItem({
    super.key,
    required this.bookItem,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteNames.bookDetail,
          arguments: bookItem,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorConst.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              spreadRadius: 6,
              blurRadius: 6,
              color: Colors.grey.shade300,
              offset: const Offset(1, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                imageUrl: bookItem.image,
                height: 120.h,
                placeholder: (context, url) {
                  return RectangleShimmerItem(
                    height: 120.h,
                    width: 90.w,
                  );
                },
              ),
            ),
            SizedBox(width: 20.h),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookItem.bookName,
                    maxLines: 2,
                    style: PoppinsFont.w400.copyWith(
                      fontSize: 15.sp,
                      color: ColorConst.blackWithOpacity063,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    bookItem.categoryName,
                    style: PoppinsFont.w500.copyWith(
                      fontSize: 15.sp,
                      color: ColorConst.c8687E7,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bookItem.language,
                        style: PoppinsFont.w300.copyWith(
                          fontSize: 15.sp,
                          color: ColorConst.blackWithOpacity063,
                        ),
                      ),
                      GestureDetector(
                        onTap: onDeleteTap,
                        child: SvgPicture.asset(
                          MyIcons.deleteIcon,
                          height: 18.h,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  final BookModel bookItem;
  final VoidCallback onDeleteTap;
}
