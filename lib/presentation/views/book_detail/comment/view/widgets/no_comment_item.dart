import 'package:book_store/presentation/utils/constants/poppins_font.dart';
import 'package:book_store/presentation/utils/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class NoCommentItem extends StatelessWidget {
  const NoCommentItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          MyIcons.noCommentLottie,
          reverse: true,
          height: MediaQuery.of(context).size.height * 0.25,
        ),
        SizedBox(height: 20.h),
        Text(
          "No comments",
          style: PoppinsFont.w600,
        ),
      ],
    );
  }
}
