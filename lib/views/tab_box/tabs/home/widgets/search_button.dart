import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/my_colors.dart';
import '../../../../../utils/my_fonts.dart';
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
        primary: MyColors.c8687E7,
      ),
      onPressed: searchOnPressed,
      child: Row(children: [
        Image.asset(
          MyIcons.searchIcon,
          height: 24,
        ),
        SizedBox(width: 30.w),
        Text(
          "Search",
          style: MyFonts.w500.copyWith(
            fontSize: 18.sp,
            color: MyColors.blackWithOpacity063,
          ),
        )
      ]),
    );
  }

  final VoidCallback searchOnPressed;
}
