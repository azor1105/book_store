import 'package:book_store/presentation/widgets/shimmers/rectangle_shimmer_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants/color_const.dart';

class CategoryBookImgItem extends StatelessWidget {
  const CategoryBookImgItem({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: ColorConst.cE5E5E5,
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) {
          return const RectangleShimmerItem();
        },
      ),
    );
  }

  final String imageUrl;
}
