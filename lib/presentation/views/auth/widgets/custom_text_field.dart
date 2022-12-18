import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/my_colors.dart';
import '../../../../utils/my_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.validator,
    required this.controller,
    required this.isObsecure,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObsecure,
      controller: controller,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: MyFonts.w400.copyWith(
        fontSize: 15.sp,
      ),
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: MyFonts.w400.copyWith(
          fontSize: 15.sp,
        ),
        fillColor: MyColors.cF1F4FA,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            width: 1.w,
            color: MyColors.cF1F4FA,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            width: 1.w,
            color: MyColors.cF1F4FA,
          ),
        ),
      ),
    );
  }

  final TextEditingController controller;
  final bool isObsecure;
  final String hintText;
  final String? Function(String? v) validator;
}
