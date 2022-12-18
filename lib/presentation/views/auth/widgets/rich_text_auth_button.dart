import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/my_colors.dart';
import '../../../../utils/my_fonts.dart';

class RichTextAuthButton extends StatelessWidget {
  const RichTextAuthButton({
    super.key,
    required this.onPressed,
    required this.firstText,
    required this.secondText,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: RichText(
        text: TextSpan(
          text: firstText,
          style: MyFonts.w400.copyWith(
            fontSize: 15.sp,
          ),
          children: [
            TextSpan(
              text: secondText,
              style: MyFonts.w600.copyWith(
                fontSize: 15.sp,
                color: MyColors.c8687E7,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final VoidCallback onPressed;
  final String firstText;
  final String secondText;
}
