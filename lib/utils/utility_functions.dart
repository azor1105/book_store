import 'package:book_store/utils/my_colors.dart';
import 'package:book_store/utils/my_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyUtils {
  static getMyToast({required String message}) => Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor: MyColors.c8687E7,
        textColor: Colors.white,
        fontSize: 16.sp,
      );

  static void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static String capitalize(String word) {
    return "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}";
  }

  static showSnackBar(BuildContext context, String? text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text ?? "",
          style: MyFonts.w500.copyWith(
            fontSize: 16.sp,
            color: MyColors.white,
          ),
        ),
        backgroundColor: MyColors.c8687E7,
      ),
    );
  }

  static showLoader(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
