import 'package:book_store/app/app_cubit/app_cubit.dart';
import 'package:book_store/presentation/utils/constants/color_const.dart';
import 'package:book_store/presentation/utils/constants/poppins_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void changePictureBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    barrierColor: Colors.transparent,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10.r),
        topLeft: Radius.circular(10.r),
      ),
    ),
    backgroundColor: Colors.white,
    builder: (BuildContext bc) {
      return Container(
        decoration: BoxDecoration(
          color: ColorConst.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 5,
              blurRadius: 5,
              color: Colors.grey.shade300,
              offset: const Offset(1, 3),
            )
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          ),
        ),
        padding: EdgeInsets.all(16.sp),
        height: MediaQuery.of(context).size.height * 0.27,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Change account Image",
                  style: PoppinsFont.w700.copyWith(
                    fontSize: 16.sp,
                    color: ColorConst.blackWithOpacity087,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Divider(height: 1.h, color: ColorConst.c979797),
              SizedBox(height: 28.h),
              ListTile(
                onTap: () async {
                  Navigator.of(context).pop();
                  context.read<AppCubit>().uploadImg();
                },
                title: Text(
                  "Take picture",
                  style: PoppinsFont.w400.copyWith(
                    color: ColorConst.blackWithOpacity087,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              ListTile(
                onTap: () async {
                  Navigator.of(context).pop();
                  context.read<AppCubit>().uploadImg(fromCamera: false);
                },
                title: Text(
                  "Import from gallery",
                  style: PoppinsFont.w400.copyWith(
                    color: ColorConst.blackWithOpacity087,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
