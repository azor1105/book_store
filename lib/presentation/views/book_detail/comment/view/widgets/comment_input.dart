import 'package:book_store/presentation/utils/constants/color_const.dart';
import 'package:book_store/presentation/utils/constants/poppins_font.dart';
import 'package:book_store/presentation/utils/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentInput extends StatelessWidget {
  const CommentInput({
    super.key,
    required this.msgController,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: msgController,
      style: PoppinsFont.w400.copyWith(
        fontSize: 15.sp,
      ),
      maxLines: 5,
      minLines: 1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.sp),
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: GestureDetector(
            onTap: onSend,
            child: SvgPicture.asset(MyIcons.sendIcon),
          ),
        ),
        hintText: "Message",
        hintStyle: PoppinsFont.w400.copyWith(
          fontSize: 15.sp,
        ),
        fillColor: ColorConst.cF1F4FA,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
          borderSide: BorderSide(
            width: 1.w,
            color: ColorConst.cF1F4FA,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
          borderSide: BorderSide(
            width: 1.w,
            color: ColorConst.cF1F4FA,
          ),
        ),
      ),
    );
  }

  final TextEditingController msgController;
  final VoidCallback onSend;
}
