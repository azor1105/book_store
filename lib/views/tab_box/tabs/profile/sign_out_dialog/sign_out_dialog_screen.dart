import 'package:book_store/providers/auth_provider.dart';
import 'package:book_store/views/on_boarding/on_boarding_screens/widgets/text_button_with_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../../../utils/my_colors.dart';
import '../../../../../../../utils/my_fonts.dart';
import '../widgets/outlined_text_button.dart';

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: MyColors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.25,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Log out",
              style: MyFonts.w700.copyWith(
                fontSize: 16.sp,
                color: MyColors.blackWithOpacity087,
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
              height: 24.w,
            ),
            Text(
              "Are you sure?",
              style: MyFonts.w500.copyWith(
                fontSize: 15.sp,
                color: MyColors.blackWithOpacity087,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
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
                      height: 30,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: TextButtonWithBackground(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await context.read<AuthProvider>().signOut(context);
                      },
                      title: "Log out",
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
