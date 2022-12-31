import 'package:book_store/presentation/utils/my_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants/color_const.dart';

class MyOutlinedButton extends StatelessWidget {
  const MyOutlinedButton({
    Key? key,
    required this.width,
    required this.onPressed,
    required this.height,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: ColorConst.c8875FF,
          side: const BorderSide(width: 2, color: ColorConst.c8E7CFF),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style:
              MyFonts.w400.copyWith(color: ColorConst.c8687E7, fontSize: 16.sp),
        ),
      ),
    );
  }

  final VoidCallback onPressed;
  final double height;
  final double width;
  final String title;
}
