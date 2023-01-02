import 'package:book_store/presentation/utils/constants/color_const.dart';
import 'package:book_store/presentation/views/on_boarding/on_boarding_screens/first_on_boarding_screen.dart';
import 'package:book_store/presentation/views/on_boarding/on_boarding_screens/second_on_boarding_screen.dart';
import 'package:book_store/presentation/views/on_boarding/on_boarding_screens/third_on_boarding_screen.dart';
import 'package:book_store/presentation/views/on_boarding/on_boarding_screens/widgets/movement_animation_on_boarding.dart';
import 'package:book_store/presentation/widgets/buttons/simple_text_button.dart';
import 'package:book_store/presentation/widgets/buttons/text_button_with_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainOnBoardingScreen extends StatefulWidget {
  const MainOnBoardingScreen({super.key});

  @override
  State<MainOnBoardingScreen> createState() => _MainOnBoardingScreenState();
}

class _MainOnBoardingScreenState extends State<MainOnBoardingScreen> {
  PageController pageController = PageController(initialPage: 0);
  int currentPageIndex = 0;
  String buttonText = "NEXT";
  final List<Widget> _screens = [
    const FirstOnBoardingScreen(),
    const SecondOnBoardingScreen(),
    const ThirdOnBoardingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.white,
      body: currentPageIndex == _screens.length
          ? const MainOnBoardingScreen()
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 14.h),
                    child: SimpleTextButton(
                      onPressed: () {
                        setState(() {
                          currentPageIndex = _screens.length;
                        });
                      },
                      title: "SKIP",
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        PageView(
                          controller: pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: _screens,
                        ),
                        Positioned(
                          top: (MediaQuery.of(context).size.height * 0.35 + 40),
                          left: MediaQuery.of(context).size.width / 2 - 50,
                          child: Align(
                            alignment: Alignment.center,
                            child: MovementAnimationOnBoarding(
                              indexOfContainer: currentPageIndex,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SimpleTextButton(
                          title: "Back",
                          onPressed: () {
                            if (currentPageIndex > 0) {
                              setState(
                                () {
                                  currentPageIndex--;
                                  pageController.jumpToPage(currentPageIndex);
                                  buttonText = "NEXT";
                                },
                              );
                            }
                          },
                        ),
                        TextButtonWithBackground(
                          onPressed: () {
                            setState(() {
                              currentPageIndex++;
                              pageController.jumpToPage(currentPageIndex);
                            });

                            if (currentPageIndex == 2) {
                              setState(() {
                                buttonText = "GET STARTED";
                              });
                            }
                          },
                          title: buttonText,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
    );
  }
}
