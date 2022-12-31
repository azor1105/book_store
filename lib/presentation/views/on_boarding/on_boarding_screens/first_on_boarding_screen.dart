import 'package:book_store/presentation/utils/constants/poppins_font.dart';
import 'package:book_store/presentation/utils/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstOnBoardingScreen extends StatelessWidget {
  const FirstOnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          MyIcons.onBoardingImg1,
          height: MediaQuery.of(context).size.height * 0.35,
        ),
        SizedBox(height: 40.h),
        SizedBox(height: 40.h),
        Center(
          child: Text(
            "Read any book anywhere",
            style: PoppinsFont.w700.copyWith(fontSize: 25.sp),
          ),
        ),
        SizedBox(height: 40.h),
        Center(
          child: Text(
            "You can easily find and read any book\nyou want anywhere for free",
            textAlign: TextAlign.center,
            style: PoppinsFont.w400.copyWith(fontSize: 14.sp),
          ),
        )
      ],
    );
  }
}
