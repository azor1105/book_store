import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants/color_const.dart';
import '../../utils/constants/poppins_font.dart';

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
        foregroundColor: ColorConst.c8687E7,
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: PoppinsFont.w400.copyWith(
          fontSize: 16.sp,
          color: ColorConst.blackWithOpacity044,
        ),
      ),
    );
  }

  final String title;
  final VoidCallback onPressed;
}
