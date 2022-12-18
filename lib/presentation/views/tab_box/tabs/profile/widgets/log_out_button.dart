import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../utils/my_colors.dart';
import '../../../../../utils/my_fonts.dart';
import '../../../../../utils/my_icons.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: MyColors.c8687E7,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        height: 48.h,
        child: Center(
          child: Row(
            children: [
              SvgPicture.asset(
                MyIcons.logoutIcon,
                color: MyColors.cFF4949,
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                "Log out",
                style: MyFonts.w400.copyWith(
                  color: MyColors.cFF4949,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final VoidCallback onPressed;
}
