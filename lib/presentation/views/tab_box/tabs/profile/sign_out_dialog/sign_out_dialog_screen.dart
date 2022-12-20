import 'package:book_store/data/repositories/auth_repository.dart';
import 'package:book_store/presentation/widgets/buttons/text_button_with_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/my_colors.dart';
import '../../../../../utils/my_fonts.dart';
import '../../../../../widgets/buttons/outlined_text_button.dart';

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      elevation: 0.0,
      backgroundColor: MyColors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.23,
        padding: EdgeInsets.all(15.sp),
        child: Column(
          children: [
            Text(
              "Log out",
              style: MyFonts.w700.copyWith(
                fontSize: 16.sp,
                color: MyColors.blackWithOpacity087,
              ),
            ),
            SizedBox(height: 10.h),
            Divider(height: 1.h, color: MyColors.c979797),
            SizedBox(height: 24.w),
            Text(
              "Are you sure?",
              style: MyFonts.w500.copyWith(
                fontSize: 15.sp,
                color: MyColors.blackWithOpacity087,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: MyOutlinedButton(
                    width: double.infinity,
                    title: Text(
                      "Cancel",
                      style: MyFonts.w400.copyWith(color: MyColors.c8687E7),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    height: 40.h,
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: TextButtonWithBackground(
                    height: 40.h,
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await context.read<AuthRepository>().signOut(context);
                    },
                    title: "Log out",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
