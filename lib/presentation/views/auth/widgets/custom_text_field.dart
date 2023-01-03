import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/constants/color_const.dart';
import '../../../utils/constants/poppins_font.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.validator,
    required this.controller,
    required this.isObsecure,
    required this.hintText,
    this.maxLines,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObsecure,
      controller: controller,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: PoppinsFont.w400.copyWith(
        fontSize: 15.sp,
      ),
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: PoppinsFont.w400.copyWith(
          fontSize: 15.sp,
        ),
        fillColor: ColorConst.cF1F4FA,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            width: 1.w,
            color: ColorConst.cF1F4FA,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            width: 1.w,
            color: ColorConst.cF1F4FA,
          ),
        ),
      ),
    );
  }

  final TextEditingController controller;
  final bool isObsecure;
  final String hintText;
  final String? Function(String? v)? validator;
  final int? maxLines;
  final int? minLines;
}
