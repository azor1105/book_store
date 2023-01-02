import 'package:book_store/app/app_cubit/app_cubit.dart';
import 'package:book_store/data/models/status.dart';
import 'package:book_store/presentation/utils/constants/color_const.dart';
import 'package:book_store/presentation/utils/constants/poppins_font.dart';
import 'package:book_store/presentation/utils/my_icons.dart';
import 'package:book_store/presentation/views/tab_box/tabs/profile/change_passwod/change_password_dialog.dart';
import 'package:book_store/presentation/views/tab_box/tabs/profile/change_picture/change_picture_bottom_sheet.dart';
import 'package:book_store/presentation/views/tab_box/tabs/profile/change_user_name/change_user_name_dialog.dart';
import 'package:book_store/presentation/views/tab_box/tabs/profile/sign_out_dialog/sign_out_dialog_screen.dart';
import 'package:book_store/presentation/views/tab_box/tabs/profile/widgets/log_out_button.dart';
import 'package:book_store/presentation/views/tab_box/tabs/profile/widgets/profile_img_item.dart';
import 'package:book_store/presentation/views/tab_box/tabs/profile/widgets/profile_option_button.dart';
import 'package:book_store/presentation/widgets/shimmers/circle_shimmer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.white,
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          if (state.user == null) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Profile",
                      style: PoppinsFont.w400.copyWith(
                        color: ColorConst.blackWithOpacity087,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Center(
                    child: state.status == Status.loading
                        ? const CircleShimmerItem()
                        : ProfileImgItem(
                            photoURL: state.user?.photoUrl,
                          ),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: Text(
                      state.user?.fullName ?? '',
                      style: PoppinsFont.w500.copyWith(
                        color: ColorConst.blackWithOpacity087,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Settings",
                    style: PoppinsFont.w400.copyWith(
                      fontSize: 14.sp,
                      color: ColorConst.cAFAFAF,
                    ),
                  ),
                  ProfileItemButton(
                    onPressed: () {},
                    iconPath: MyIcons.settingsIcon,
                    title: "App Settings",
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Account",
                    style: PoppinsFont.w400.copyWith(
                      fontSize: 14.sp,
                      color: ColorConst.cAFAFAF,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  ProfileItemButton(
                    onPressed: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => ChangeUserNameDialog(
                          userName: state.user!.fullName,
                        ),
                      );
                    },
                    iconPath: MyIcons.profileScreenUserIcon,
                    title: "Change account name",
                  ),
                  ProfileItemButton(
                    onPressed: () async {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => ChangePasswordDialog(
                          oldPassword: state.user!.password,
                        ),
                      );
                    },
                    iconPath: MyIcons.passwordIcon,
                    title: "Change account password",
                  ),
                  ProfileItemButton(
                    onPressed: () async {
                      changePictureBottomSheet(context);
                    },
                    iconPath: MyIcons.cameraIcon,
                    title: "Change account Image",
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "AzorBook",
                    style: PoppinsFont.w400.copyWith(
                      fontSize: 14.sp,
                      color: ColorConst.cAFAFAF,
                    ),
                  ),
                  ProfileItemButton(
                    onPressed: () {},
                    iconPath: MyIcons.aboutUsIcon,
                    title: "About US",
                  ),
                  LogOutButton(onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => const SignOutDialog(),
                    );
                  }),
                ],
              ),
            ),
          );

        },
      ),
    );
  }
}
