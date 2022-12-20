import 'package:book_store/data/repositories/auth_repository.dart';
import 'package:book_store/presentation/utils/constants/shared_pref_keys.dart';
import 'package:book_store/data/local_data/local_data.dart';
import 'package:book_store/presentation/utils/my_colors.dart';
import 'package:book_store/presentation/views/auth/widgets/rich_text_auth_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../utils/my_fonts.dart';
import '../../../utils/my_icons.dart';
import '../../../widgets/buttons/custom_rectangle_text_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/or_line_item.dart';
import '../widgets/sign_in_with_item.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.switchAuthPages,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
  final VoidCallback switchAuthPages;
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Center(
                  child: Text(
                    "Log in",
                    style: MyFonts.w500.copyWith(
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 22.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: CustomTextField(
                  controller: emailController,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? "Enter a valid email"
                          : null,
                  isObsecure: false,
                  hintText: "Email Address",
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
              Padding(
                padding: EdgeInsets.only(top: 17.h, left: 24.w, bottom: 42.h),
                child: Text(
                  "Forgot Password?",
                  style: MyFonts.w500.copyWith(
                    fontSize: 15.sp,
                    color: MyColors.c8687E7,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: CustomRectangleTextButton(
                  onPressed: () async {
                    await context.read<AuthRepository>().signIn(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          context: context,
                        );
                    await StorageRepository.putBool(
                        key: SharedPrefKeys.showOnBoarding, value: true);
                    await StorageRepository.putString(
                        key: SharedPrefKeys.userPassword,
                        value: passwordController.text);
                  },
                  title: "LOG IN",
                ),
              ),
              SizedBox(height: 24.h),
              Center(
                  child: RichTextAuthButton(
                firstText: "Don't have an account? ",
                secondText: "Sign up",
                onPressed: widget.switchAuthPages,
              )),
              SizedBox(height: 30.h),
              const OrLineItem(),
              SizedBox(height: 22.h),
              SignInWithItem(
                iconPath: MyIcons.googleIcon,
                title: "Google",
                onPressed: () {},
              ),
              SizedBox(height: 16.h),
              SignInWithItem(
                iconPath: MyIcons.appleIcon,
                title: "Apple",
                onPressed: () {},
              ),
              SizedBox(height: 16.h),
              SignInWithItem(
                iconPath: MyIcons.facebookIcon,
                title: "Facebook",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
