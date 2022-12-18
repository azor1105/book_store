import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/my_fonts.dart';
import '../utils/my_icons.dart';

class NoBookItem extends StatelessWidget {
  const NoBookItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(MyIcons.noBookLottie, reverse: true),
          Text(
            "Sorry but no books",
            style: MyFonts.w600,
          ),
        ],
      ),
    );
  }
}
