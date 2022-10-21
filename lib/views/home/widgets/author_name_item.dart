import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/my_colors.dart';
import '../../../utils/my_fonts.dart';

class AuthorNameItem extends StatelessWidget {
  const AuthorNameItem({
    super.key,
    required this.authorName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: MyColors.white,
            border: Border.all(width: 1, color: Colors.grey)),
        child: Text(
          authorName,
          style: MyFonts.w600.copyWith(
            fontSize: 13.sp,
            color: MyColors.blackWithOpacity087,
          ),
        ),
      ),
    );
  }

  final String authorName;
  final VoidCallback onTap;
}
