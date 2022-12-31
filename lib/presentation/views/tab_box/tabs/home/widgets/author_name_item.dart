import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/color_const.dart';
import '../../../../../utils/my_fonts.dart';

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
        padding: EdgeInsets.all(5.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: ColorConst.white,
            border: Border.all(width: 1.w, color: Colors.grey)),
        child: Text(
          authorName,
          style: MyFonts.w600.copyWith(
            fontSize: 13.sp,
            color: ColorConst.blackWithOpacity087,
          ),
        ),
      ),
    );
  }

  final String authorName;
  final VoidCallback onTap;
}
