import 'package:book_store/providers/auth_provider.dart';
import 'package:book_store/utils/utility_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../utils/my_colors.dart';
import '../../../../utils/my_fonts.dart';
import '../widgets/pick_img.dart';

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
                  var file = await getFromCamera(() {});
                  Navigator.of(context).pop();
                  if (file != null) {
                    MyUtils.showLoader(context);
                    String imageUrl = await context
                        .read<AuthProvider>()
                        .uploadImage(file, context);
                    var user = context.read<User?>();
                    await user!.updatePhotoURL(imageUrl);
                    Navigator.of(context).pop();
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
                  var file = await getFromGallery(() {});
                  Navigator.of(context).pop();
                  if (file != null) {
                    MyUtils.showLoader(context);
                    String imageUrl = await context
                        .read<AuthProvider>()
                        .uploadImage(file, context);
                    var user = context.read<User?>();
                    await user!.updatePhotoURL(imageUrl);
                    Navigator.of(context).pop();
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
