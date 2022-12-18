import 'package:book_store/presentation/utils/my_fonts.dart';
import 'package:book_store/presentation/utils/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondOnBoardingScreen extends StatelessWidget {
  const SecondOnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          MyIcons.onBoardingImg2,
          height: MediaQuery.of(context).size.height * 0.35,
        ),
        SizedBox(height: 40.h),
        SizedBox(height: 40.h),
        Center(
          child: Text(
            "Find the right book",
            style: MyFonts.w700.copyWith(fontSize: 25.sp),
          ),
        ),
        SizedBox(height: 40.h),
        Center(
          child: Text(
            "In AzorBook you can find books\non your favourite genre",
            textAlign: TextAlign.center,
            style: MyFonts.w400.copyWith(fontSize: 14.sp),
          ),
        )
      ],
    );
  }
}