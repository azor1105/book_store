import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/constants/color_const.dart';
import '../../../../../utils/constants/poppins_font.dart';
import '../../../../../utils/my_icons.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
    required this.searchOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: ColorConst.c8687E7,
      ),
      onPressed: searchOnPressed,
      child: Row(
        children: [
          Image.asset(
            MyIcons.searchIcon,
            height: 24.h,
          ),
          SizedBox(width: 30.w),
          Text(
            "Search",
            style: PoppinsFont.w500.copyWith(
              fontSize: 18.sp,
              color: ColorConst.blackWithOpacity063,
            ),
          )
        ],
      ),
    );
  }

  final VoidCallback searchOnPressed;
}
