import 'package:book_store/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/my_fonts.dart';

class SeeAllItem extends StatelessWidget {
  const SeeAllItem({
    super.key,
    required this.title,
    required this.seeAllOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: MyFonts.w600.copyWith(
              fontSize: 14.sp,
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: MyColors.c8687E7,
            ),
            onPressed: seeAllOnPressed,
            child: Text(
              "See all>",
              style: MyFonts.w500.copyWith(
                fontSize: 12.sp,
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final String title;
  final VoidCallback seeAllOnPressed;
}
