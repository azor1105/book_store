import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/color_const.dart';
import '../../utils/my_fonts.dart';

class TextButtonWithBackground extends StatelessWidget {
  const TextButtonWithBackground({
    super.key,
    required this.onPressed,
    required this.title,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48.h,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 500),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: ColorConst.c8687E7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            title,
            style: MyFonts.w400.copyWith(
              fontSize: 16.sp,
              color: ColorConst.white,
            ),
          ),
        ),
      ),
    );
  }

  final VoidCallback onPressed;
  final String title;
  final double? height;
}
