import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/poppins_font.dart';
import '../../../utils/my_icons.dart';

class ThirdOnBoardingScreen extends StatelessWidget {
  const ThirdOnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          MyIcons.onBoardingImg3,
          height: MediaQuery.of(context).size.height * 0.35,
        ),
        SizedBox(height: 40.h),
        SizedBox(height: 40.h),
        Center(
          child: Text(
            "Read best seeller books",
            style: PoppinsFont.w700.copyWith(fontSize: 25.sp),
          ),
        ),
        SizedBox(height: 40.h),
        Center(
          child: Text(
            "Azorbook gives to chance to read best seller\nbooks around the world for free",
            textAlign: TextAlign.center,
            style: PoppinsFont.w400.copyWith(fontSize: 14.sp),
          ),
        )
      ],
    );
  }
}
