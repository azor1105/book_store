import 'package:book_store/data/repositories/auth_repository.dart';
import 'package:book_store/presentation/utils/constants/color_const.dart';
import 'package:book_store/presentation/utils/my_icons.dart';
import 'package:book_store/presentation/utils/utility_functions.dart';
import 'package:book_store/presentation/views/auth/widgets/rich_text_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../utils/constants/shared_pref_keys.dart';
import '../../../../data/local_data/local_data.dart';
import '../../../utils/my_fonts.dart';
import '../../../widgets/buttons/custom_rectangle_text_button.dart';
import '../widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
    required this.switchAuthPages,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
  final VoidCallback switchAuthPages;
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  MyIcons.signUpLottie,
                  reverse: true,
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                Text(
                  "Sing up",
                  style: MyFonts.w500.copyWith(
                    fontSize: 18.sp,
                    color: ColorConst.c090A0A,
                  ),
                ),
                SizedBox(height: 22.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: CustomTextField(
                    controller: emailController,
                    validator: MyUtils.validateEmail,
                    isObsecure: false,
                    hintText: "Email Address",
                  ),
                ),
                SizedBox(height: 17.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: CustomTextField(
                    controller: nameController,
                    validator: (name) => name != null && name.length < 4
                        ? "User name must be minimum 4 characters"
                        : null,
                    isObsecure: false,
                    hintText: "Username",
                  ),
                ),
                SizedBox(height: 17.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: CustomTextField(
                    controller: passwordController,
                    validator: (password) =>
                        password != null && password.length < 6
                            ? "Enter at least 6 charcter !"
                            : null,
                    isObsecure: true,
                    hintText: "Password",
                  ),
                ),
                SizedBox(height: 17.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: CustomTextField(
                    controller: confirmPasswordController,
                    validator: (password) =>
                        password != null && password.length < 6
                            ? "Enter at least 6 charcter !"
                            : null,
                    isObsecure: true,
                    hintText: "Confirm password",
                  ),
                ),
                SizedBox(height: 42.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: CustomRectangleTextButton(
                    onPressed: () async {
                      await context.read<AuthRepository>().signUp(
                            email: emailController.text,
                            password: passwordController.text,
                            context: context,
                          );
                      await context.read<AuthRepository>().updateDisplayName(
                            context: context,
                            displayName: nameController.text.trim(),
                          );
                      await StorageRepository.putBool(
                          key: SharedPrefKeys.showOnBoarding, value: true);
                      await StorageRepository.putString(
                          key: SharedPrefKeys.userPassword,
                          value: passwordController.text);
                    },
                    title: "SIGN UP",
                  ),
                ),
                SizedBox(height: 24.h),
                RichTextAuthButton(
                  onPressed: widget.switchAuthPages,
                  firstText: "Already have an account? ",
                  secondText: "Log in",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
