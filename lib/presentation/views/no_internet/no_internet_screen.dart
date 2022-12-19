import 'package:book_store/presentation/utils/constants/route_names.dart';
import 'package:book_store/presentation/utils/my_colors.dart';
import 'package:book_store/presentation/utils/my_fonts.dart';
import 'package:book_store/presentation/utils/my_icons.dart';
import 'package:book_store/presentation/widgets/buttons/custom_rectangle_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: Column(
          children: [
            const Spacer(),
            Lottie.asset(
              MyIcons.noInternetLottie,
              reverse: true,
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.w),
              child: Text(
                'Please check the internet connection',
                style: MyFonts.w600.copyWith(fontSize: 18.sp),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomRectangleTextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.downloadedBooks);
                },
                title: 'Read downloaded books',
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
