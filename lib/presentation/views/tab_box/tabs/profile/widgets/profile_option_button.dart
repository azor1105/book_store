import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../utils/constants/color_const.dart';
import '../../../../../utils/constants/poppins_font.dart';
import '../../../../../utils/my_icons.dart';

class ProfileItemButton extends StatelessWidget {
  const ProfileItemButton({
    Key? key,
    required this.onPressed,
    required this.iconPath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: ColorConst.c8687E7,
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
                iconPath,
                color: ColorConst.blackWithOpacity087,
                height: 18.h,
              ),
              SizedBox(width: 12.w),
              Text(
                title,
                style: PoppinsFont.w400.copyWith(
                  color: ColorConst.blackWithOpacity087,
                  fontSize: 16.sp,
                ),
              ),
              const Expanded(child: SizedBox()),
              SvgPicture.asset(
                MyIcons.intoIcon,
                color: ColorConst.blackWithOpacity087,
                height: 15.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  final String iconPath;
  final String title;
  final VoidCallback onPressed;
}
