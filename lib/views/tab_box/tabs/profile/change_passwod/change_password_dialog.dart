import 'package:book_store/providers/auth_provider.dart';
import 'package:book_store/utils/utility_functions.dart';
import 'package:book_store/views/on_boarding/on_boarding_screens/widgets/text_button_with_background.dart';
import 'package:book_store/views/tab_box/tabs/profile/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../../../utils/my_colors.dart';
import '../../../../../../../utils/my_fonts.dart';
import '../widgets/outlined_text_button.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({
    Key? key,
    required this.oldPassword,
  }) : super(key: key);
  final String oldPassword;
  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode oldPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    newPasswordFocusNode.dispose();
    oldPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      elevation: 0.0,
      backgroundColor: MyColors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.48,
        padding: EdgeInsets.all(15.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Change password",
                style: MyFonts.w700.copyWith(
                  fontSize: 16.sp,
                  color: MyColors.blackWithOpacity087,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Divider(height: 1.h, color: MyColors.c979797),
            SizedBox(height: 10.h),
            Text(
              "Enter old password",
              style: MyFonts.w400.copyWith(
                fontSize: 14.sp,
                color: MyColors.blackWithOpacity087,
              ),
            ),
            SizedBox(height: 8.h),
            UniversalTextField(
              controller: oldPasswordController,
              focusNode: oldPasswordFocusNode,
              maxLength: 12,
              obscureText: true,
              textStyle: MyFonts.w400.copyWith(
                color: MyColors.blackWithOpacity087,
                letterSpacing: 8.0,
              ),
              onSubmitted: (v) {
                MyUtils.fieldFocusChange(
                    context, oldPasswordFocusNode, newPasswordFocusNode);
              },
            ),
            SizedBox(height: 10.h),
            Text(
              "Enter new password",
              style: MyFonts.w400.copyWith(
                fontSize: 14.sp,
                color: MyColors.blackWithOpacity087,
              ),
            ),
            SizedBox(height: 8.h),
            UniversalTextField(
              controller: newPasswordController,
              focusNode: newPasswordFocusNode,
              maxLength: 12,
              obscureText: true,
              textStyle: MyFonts.w400.copyWith(
                color: MyColors.blackWithOpacity087,
                letterSpacing: 8.0,
              ),
              onSubmitted: (v) {
                newPasswordFocusNode.unfocus();
              },
            ),
            const Expanded(child: SizedBox()),
            Row(
              children: [
                Expanded(
                  child: MyOutlinedButton(
                    width: double.infinity,
                    title: Text(
                      "cancel",
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
                      if (oldPasswordController.text != widget.oldPassword) {
                        MyUtils.getMyToast(message: "Password is wrong");
                      } else if (newPasswordController.text.length < 6) {
                        MyUtils.getMyToast(
                          message: 'Password must be\n minimum 6 symbols',
                        );
                      } else {
                        Navigator.of(context).pop();
                        await context.read<AuthProvider>().updatePassword(
                              context: context,
                              password: newPasswordController.text.trim(),
                            );
                        await context.read<AuthProvider>().signOut(context);
                        MyUtils.getMyToast(message: "You need to sign in");
                      }
                    },
                    title: "Edit",
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
