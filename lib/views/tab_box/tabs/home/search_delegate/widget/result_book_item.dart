import 'package:book_store/data/models/book/book_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/my_colors.dart';
import '../../../../../on_boarding/on_boarding_screens/widgets/text_button_with_background.dart';
import '../../widgets/rectangle_shimmer_item.dart';

class ResultBookItem extends StatelessWidget {
  const ResultBookItem({super.key, required this.resultBookItem, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 5,
                  blurRadius: 5,
                  color: MyColors.blackWithOpacity063,
                  offset: const Offset(1, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: resultBookItem.image,
                height: 250,
                placeholder: (context, url) {
                  return const RectangleShimmerItem();
                },
              ),
            ),
          ),
          SizedBox(height: 30.h),
          TextButtonWithBackground(
            onPressed: onTap,
            title: "View more info",
          ),
        ],
      ),
    );
  }

  final BookModel resultBookItem;
  final VoidCallback onTap;
}
