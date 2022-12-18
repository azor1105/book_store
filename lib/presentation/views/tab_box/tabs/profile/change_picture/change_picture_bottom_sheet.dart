import 'package:book_store/providers/auth_provider.dart';
import 'package:book_store/presentation/utils/my_colors.dart';
import 'package:book_store/presentation/utils/my_fonts.dart';
import 'package:book_store/presentation/utils/utility_functions.dart';
import 'package:book_store/presentation/views/tab_box/tabs/profile/widgets/pick_img.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          color: MyColors.white,
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
                  style: MyFonts.w700.copyWith(
                    fontSize: 16.sp,
                    color: MyColors.blackWithOpacity087,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Divider(height: 1.h, color: MyColors.c979797),
              SizedBox(height: 28.h),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  var file = await getFromCamera(() {});
                  if (file != null) {
                    String imageUrl = await context
                        .read<AuthProvider>()
                        .uploadImage(file, context);
                    var user = context.read<User?>();
                    await user!.updatePhotoURL(imageUrl);
                  } else {
                    MyUtils.getMyToast(message: 'Image is not picked');
                  }
                },
                child: Text(
                  "Take picture",
                  style: MyFonts.w400.copyWith(
                    color: MyColors.blackWithOpacity087,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  var file = await getFromGallery(() {});
                  if (file != null) {
                    String imageUrl = await context
                        .read<AuthProvider>()
                        .uploadImage(file, context);
                    var user = context.read<User?>();
                    await user!.updatePhotoURL(imageUrl);
                  } else {
                    MyUtils.getMyToast(message: 'Image is not picked');
                  }
                },
                child: Text(
                  "Import from gallery",
                  style: MyFonts.w400.copyWith(
                    color: MyColors.blackWithOpacity087,
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
