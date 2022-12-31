import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants/color_const.dart';
import '../../utils/constants/poppins_font.dart';

class CustomRectangleTextButton extends StatelessWidget {
  const CustomRectangleTextButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 56.h,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: ColorConst.c8687E7,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 8.r),
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            title,
            style: PoppinsFont.w500.copyWith(
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
  final double? radius;
}
