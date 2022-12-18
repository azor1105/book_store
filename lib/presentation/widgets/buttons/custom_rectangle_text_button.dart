import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/my_colors.dart';
import '../../utils/my_fonts.dart';

class CustomRectangleTextButton extends StatelessWidget {
  const CustomRectangleTextButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: MyColors.c8687E7,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            title,
            style: MyFonts.w500.copyWith(
              fontSize: 16.sp,
              color: MyColors.white,
            ),
          ),
        ),
      ),
    );
  }

  final VoidCallback onPressed;
  final String title;
}
