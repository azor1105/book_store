import 'package:book_store/providers/auth_provider.dart';
import 'package:book_store/utils/my_colors.dart';
import 'package:book_store/utils/my_fonts.dart';
import 'package:book_store/utils/utility_functions.dart';
import 'package:book_store/views/tab_box/tabs/profile/widgets/pick_img.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


void changePictureBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    barrierColor: Colors.transparent,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(12),
        topLeft: Radius.circular(12),
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
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        padding: const EdgeInsets.all(16),
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
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: MyColors.c979797,
              ),
              SizedBox(
                height: 28.h,
              ),
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