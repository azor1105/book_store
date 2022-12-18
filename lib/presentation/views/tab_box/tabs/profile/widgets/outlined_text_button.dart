import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/my_colors.dart';

class MyOutlinedButton extends StatelessWidget {
  const MyOutlinedButton({
    Key? key,
    required this.width,
    required this.title,
    required this.onPressed,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: MyColors.c8875FF,
          side: const BorderSide(width: 2, color: MyColors.c8E7CFF),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        onPressed: onPressed,
        child: title,
      ),
    );
  }

  final VoidCallback onPressed;
  final double height;
  final double width;
  final Widget title;
}
