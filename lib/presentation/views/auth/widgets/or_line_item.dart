import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/color_const.dart';
import '../../../utils/constants/poppins_font.dart';

class OrLineItem extends StatelessWidget {
  const OrLineItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: ColorConst.cDEDEDE,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            child: Text(
              "OR",
              style: PoppinsFont.w500.copyWith(
                fontSize: 18.sp,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: ColorConst.cDEDEDE,
            ),
          )
        ],
      ),
    );
  }
}
