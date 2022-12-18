import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/my_colors.dart';
import '../../../../utils/my_fonts.dart';

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
        border: Border.all(width: 1, color: MyColors.c090A0A),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          foregroundColor: MyColors.c8687E7,
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
              style: MyFonts.w500.copyWith(
                fontSize: 16.sp,
                color: MyColors.black,
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
