import 'package:book_store/constants/shared_pref_keys.dart';
import 'package:book_store/data/local_data/local_data.dart';
import 'package:book_store/utils/my_colors.dart';
import 'package:book_store/utils/my_fonts.dart';
import 'package:book_store/utils/my_icons.dart';
import 'package:book_store/views/profile/change_passwod/change_password_dialog.dart';
import 'package:book_store/views/profile/change_picture/change_picture_bottom_sheet.dart';
import 'package:book_store/views/profile/change_user_name/change_user_name_dialog.dart';
import 'package:book_store/views/profile/sign_out_dialog/sign_out_dialog_screen.dart';
import 'package:book_store/views/profile/widgets/log_out_button.dart';
import 'package:book_store/views/profile/widgets/profile_img_item.dart';
import 'package:book_store/views/profile/widgets/profile_option_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User user = context.watch<User?>()!;
    return Scaffold(
      backgroundColor: MyColors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Profile",
                  style: MyFonts.w400.copyWith(
                    color: MyColors.blackWithOpacity087,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Center(
                child: ProfileImgItem(
                  photoURL: user.photoURL,
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  user.displayName!,
                  style: MyFonts.w500.copyWith(
                    color: MyColors.blackWithOpacity087,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Settings",
                style: MyFonts.w400.copyWith(
                  fontSize: 14.sp,
                  color: MyColors.cAFAFAF,
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
                style: MyFonts.w400.copyWith(
                  fontSize: 14.sp,
                  color: MyColors.cAFAFAF,
                ),
              ),
              SizedBox(height: 4.h),
              ProfileItemButton(
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => ChangeUserNameDialog(
                      userName: user.displayName!,
                      update: () {},
                    ),
                  );
                },
                iconPath: MyIcons.profileScreenUserIcon,
                title: "Change account name",
              ),
              ProfileItemButton(
                onPressed: () async {
                  String savedPassword = StorageRepository.getString(
                      keyOfValue: SharedPrefKeys.userPassword)!;
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => ChangePasswordDialog(
                      oldPassword: savedPassword,
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
                style: MyFonts.w400.copyWith(
                  fontSize: 14.sp,
                  color: MyColors.cAFAFAF,
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
      ),
    );
  }
}
