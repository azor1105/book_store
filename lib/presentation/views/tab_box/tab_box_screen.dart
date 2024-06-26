import 'package:book_store/presentation/utils/constants/color_const.dart';
import 'package:book_store/presentation/utils/constants/poppins_font.dart';
import 'package:book_store/presentation/utils/my_icons.dart';
import 'package:book_store/presentation/views/tab_box/tabs/home/home_screen.dart';
import 'package:book_store/presentation/views/tab_box/tabs/profile/profile_screen.dart';
import 'package:book_store/presentation/views/tab_box/tabs/saved/views/saved_books_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TabBoxScreen extends StatefulWidget {
  const TabBoxScreen({super.key});

  @override
  State<TabBoxScreen> createState() => _TabBoxScreenState();
}

class _TabBoxScreenState extends State<TabBoxScreen> {
  int currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const SavedBooksScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: _screens,
        ),
      ),
      backgroundColor: ColorConst.white,
      bottomNavigationBar: Container(
        height: 70.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.r),
          ),
          boxShadow: [
            BoxShadow(
              spreadRadius: 3,
              blurRadius: 3,
              color: Colors.grey.shade300,
              offset: const Offset(1, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.r),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: ColorConst.white,
            currentIndex: currentIndex,
            selectedLabelStyle: PoppinsFont.w400.copyWith(
              fontSize: 12.sp,
            ),
            unselectedLabelStyle: PoppinsFont.w400.copyWith(
              fontSize: 12.sp,
            ),
            selectedItemColor: ColorConst.c8687E7,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  currentIndex == 0
                      ? MyIcons.selectedHomeIcon
                      : MyIcons.unselectedHomeIcon,
                  height: 24.sp,
                  color: currentIndex == 0 ? ColorConst.c8687E7 : Colors.grey,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  currentIndex == 1
                      ? MyIcons.selectedSaveIcon
                      : MyIcons.unselectedSaveIcon,
                  height: 24.sp,
                  color: currentIndex == 1 ? ColorConst.c8687E7 : Colors.grey,
                ),
                label: "Saved",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  currentIndex == 2
                      ? MyIcons.selectedProfileIcon
                      : MyIcons.unselectedProfileIcon,
                  height: 24.sp,
                  color: currentIndex == 2 ? ColorConst.c8687E7 : Colors.grey,
                ),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
