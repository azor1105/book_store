import 'package:book_store/presentation/utils/constants/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


Widget closeItem() => Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: Row(
          children: [
            const Spacer(),
            Container(
              width: 50.w,
              height: 4.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                color: ColorConst.c979797,
              ),
            ),
            const Spacer(),
          ],
        ),
      );