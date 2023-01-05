import 'package:book_store/presentation/utils/constants/poppins_font.dart';
import 'package:book_store/presentation/utils/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class NoSavedBookItem extends StatelessWidget {
  const NoSavedBookItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(MyIcons.noSavedBookLottie),
        SizedBox(height: 20.h),
        Text(
          'No saved books',
          style: PoppinsFont.w600,
        ),
      ],
    );
  }
}
