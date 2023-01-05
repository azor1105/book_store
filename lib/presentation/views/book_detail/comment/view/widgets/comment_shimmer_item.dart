import 'package:book_store/presentation/widgets/shimmers/circle_shimmer_item.dart';
import 'package:book_store/presentation/widgets/shimmers/rectangle_shimmer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentShimmerItem extends StatelessWidget {
  const CommentShimmerItem({
    super.key,
    required this.width,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment:
              isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            !isUser
                ? Padding(
                    padding: EdgeInsets.only(right: 7.w),
                    child: CircleShimmerItem(
                      radius: 28.r,
                    ),
                  )
                : const SizedBox(),
            Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                RectangleShimmerItem(
                  width: 30.w,
                  height: 15.h,
                  radius: 5.r,
                ),
                SizedBox(height: 6.h),
                RectangleShimmerItem(
                  radius: 12.r,
                  width: width.w,
                  height: 45.h,
                )
              ],
            ),
            isUser
                ? Padding(
                    padding: EdgeInsets.only(left: 7.w),
                    child: CircleShimmerItem(
                      radius: 28.r,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  final double width;
  final bool isUser;
}
