import 'package:book_store/presentation/utils/constants/route_names.dart';
import 'package:book_store/presentation/utils/constants/color_const.dart';
import 'package:book_store/presentation/utils/my_fonts.dart';
import 'package:book_store/presentation/utils/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, RouteNames.main);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(MyIcons.splashLottie, repeat: false),
              SizedBox(height: 20.h),
              Text(
                "AzorBook",
                style: MyFonts.w600.copyWith(fontSize: 25.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
