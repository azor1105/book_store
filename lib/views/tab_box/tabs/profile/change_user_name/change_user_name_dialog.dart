import 'package:book_store/providers/auth_provider.dart';
import 'package:book_store/utils/utility_functions.dart';
import 'package:book_store/views/on_boarding/on_boarding_screens/widgets/text_button_with_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/my_colors.dart';
import '../../../../../utils/my_fonts.dart';

import '../widgets/outlined_text_button.dart';

class ChangeUserNameDialog extends StatefulWidget {
  const ChangeUserNameDialog({
    Key? key,
    required this.update,
    required this.userName,
  }) : super(key: key);

  @override
  State<ChangeUserNameDialog> createState() => _ChangeUserNameDialogState();
  final VoidCallback update;
  final String userName;
}

class _ChangeUserNameDialogState extends State<ChangeUserNameDialog> {
  TextEditingController userNameController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    userNameController.text = widget.userName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: MyColors.cE5E5E5,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Text(
                "Change profile name",
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
              height: 16..h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: TextField(
                maxLength: 25,
                style: MyFonts.w400.copyWith(
                  color: MyColors.blackWithOpacity087,
                ),
                controller: userNameController,
                decoration: InputDecoration(
                  counterStyle: MyFonts.w400.copyWith(fontSize: 12.sp),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.8,
                      color: MyColors.c979797,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.8,
                      color: MyColors.c979797,
                    ),
                  ),
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
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
                      height: 30,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: TextButtonWithBackground(
                      onPressed: () async {
                        bool userNameIsValid = RegExp('[a-zA-Z]')
                            .hasMatch(userNameController.text);
                        if (userNameController.text == widget.userName) {
                          MyUtils.getMyToast(
                            message: 'This name is\nalready selected',
                          );
                        } else if (userNameController.text.length < 3) {
                          MyUtils.getMyToast(
                            message: 'Name must be minimum\n 4 characters'
                          );
                        } else if (!userNameIsValid) {
                          MyUtils.getMyToast(message: 'Name is wrong');
                        } else {
                          await context.read<AuthProvider>().updateDisplayName(
                                context: context,
                                displayName: userNameController.text.trim(),
                              );
                          Navigator.of(context).pop();
                        }
                      },
                      title: "Save",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
          ],
        ),
      ),
    );
  }
}
