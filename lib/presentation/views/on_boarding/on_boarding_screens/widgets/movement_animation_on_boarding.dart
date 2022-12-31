import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants/color_const.dart';

class MovementAnimationOnBoarding extends StatelessWidget {
  const MovementAnimationOnBoarding({
    super.key,
    required this.indexOfContainer,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(
            milliseconds: 500,
          ),
          height: 4,
          width: 27,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(56),
            color: indexOfContainer == 0
                ? ColorConst.c8687E7
                : ColorConst.c8687E7.withOpacity(0.57),
          ),
        ),
        SizedBox(width: 8.w),
        AnimatedContainer(
          duration: const Duration(
            milliseconds: 500,
          ),
          height: 4,
          width: 27,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(56),
            color: indexOfContainer == 1
                ? ColorConst.c8687E7
                : ColorConst.c8687E7.withOpacity(0.57),
          ),
        ),
        SizedBox(width: 8.w),
        AnimatedContainer(
          duration: const Duration(
            milliseconds: 500,
          ),
          height: 4,
          width: 27,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(56),
            color: indexOfContainer == 2
                ? ColorConst.c8687E7
                : ColorConst.c8687E7.withOpacity(0.57),
          ),
        ),
      ],
    );
  }

  final int indexOfContainer;
}
