import 'package:book_store/presentation/utils/constants/color_const.dart';
import 'package:book_store/presentation/utils/my_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UniversalTextField extends StatelessWidget {
  const UniversalTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.maxLength,
    this.onChanged,
    this.onSubmitted,
    this.textStyle,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      onChanged: onChanged,
      focusNode: focusNode,
      maxLength: maxLength,
      style: textStyle ??
          MyFonts.w400.copyWith(
            color: ColorConst.blackWithOpacity087,
          ),
      controller: controller,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        counterStyle: MyFonts.w400.copyWith(fontSize: 12.sp),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.8,
            color: ColorConst.c979797,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.8,
            color: ColorConst.c979797,
          ),
        ),
      ),
    );
  }

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextStyle? textStyle;
  final bool obscureText;
}
// 25 maxLength