import 'package:book_store/presentation/utils/constants/color_const.dart';
import 'package:book_store/presentation/utils/constants/poppins_font.dart';
import 'package:book_store/presentation/utils/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSize {
  const SimpleAppBar({
    Key? key,
    required this.title,
    this.centerTitle = true,
    this.backButton = true,
    this.leading,
    this.actions,
  }) : super(key: key);

  final String title;
  final bool centerTitle;
  final bool backButton;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: PoppinsFont.w600,
      ),
      elevation: 0.0,
      backgroundColor: ColorConst.white,
      leading: backButton
          ? Center(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: SvgPicture.asset(
                  MyIcons.arrowBackIcon,
                  color: ColorConst.black,
                  height: 15.h,
                ),
              ),
            )
          : leading,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);

  @override
  Widget get child => throw UnimplementedError();
}
