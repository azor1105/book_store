import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/my_colors.dart';
import '../../../../utils/my_fonts.dart';

class SimpleTextButton extends StatelessWidget {
  const SimpleTextButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: MyColors.c8687E7,
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: MyFonts.w400.copyWith(
          fontSize: 16.sp,
          color: MyColors.blackWithOpacity044,
        ),
      ),
    );
  }

  final String title;
  final VoidCallback onPressed;
}
