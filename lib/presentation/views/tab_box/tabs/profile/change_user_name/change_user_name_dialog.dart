import 'package:book_store/app/app_cubit/app_cubit.dart';
import 'package:book_store/data/repositories/auth_repository.dart';
import 'package:book_store/presentation/utils/utility_functions.dart';
import 'package:book_store/presentation/widgets/buttons/text_button_with_background.dart';
import 'package:book_store/presentation/views/tab_box/tabs/profile/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/constants/color_const.dart';
import '../../../../../utils/constants/poppins_font.dart';
import '../../../../../widgets/buttons/outlined_text_button.dart';

class ChangeUserNameDialog extends StatefulWidget {
  const ChangeUserNameDialog({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  State<ChangeUserNameDialog> createState() => _ChangeUserNameDialogState();
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      elevation: 0.0,
      backgroundColor: ColorConst.cE5E5E5,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  "Change profile name",
                  style: PoppinsFont.w700.copyWith(
                    fontSize: 16.sp,
                    color: ColorConst.blackWithOpacity087,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Divider(height: 1.h, color: ColorConst.c979797),
              SizedBox(height: 16.h),
              UniversalTextField(
                controller: userNameController,
                maxLength: 25,
              ),
              const Expanded(child: SizedBox()),
              Row(
                children: [
                  Expanded(
                    child: MyOutlinedButton(
                      width: double.infinity,
                      title: 'cancel',
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
                        bool userNameIsValid = RegExp('[a-zA-Z]')
                            .hasMatch(userNameController.text);
                        if (userNameController.text == widget.userName) {
                          MyUtils.getMyToast(
                            message: 'This name is\nalready selected',
                          );
                        } else if (userNameController.text.length < 3) {
                          MyUtils.getMyToast(
                              message: 'Name must be minimum\n 4 characters');
                        } else if (!userNameIsValid) {
                          MyUtils.getMyToast(message: 'Name is wrong');
                        } else {
                          Navigator.of(context).pop();
                          context.read<AuthRepository>().updateDisplayName(
                                context: context,
                                displayName: userNameController.text.trim(),
                                docId:
                                    context.read<AppCubit>().state.user!.docId,
                              );
                        }
                      },
                      title: "Save",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
