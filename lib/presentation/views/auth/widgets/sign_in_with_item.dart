import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/color_const.dart';
import '../../../utils/constants/poppins_font.dart';

class SignInWithItem extends StatelessWidget {
  const SignInWithItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: ColorConst.c090A0A),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          foregroundColor: ColorConst.c8687E7,
        ),
        child: Row(
          children: [
            SizedBox(width: 18.w),
            Image.asset(iconPath),
            SizedBox(
              width: 45.w,
            ),
            Text(
              "Sign in with $title",
              style: PoppinsFont.w500.copyWith(
                fontSize: 16.sp,
                color: ColorConst.black,
              ),
            )
          ],
        ),
      ),
    );
  }

  final String iconPath;
  final String title;
  final VoidCallback onPressed;
}
