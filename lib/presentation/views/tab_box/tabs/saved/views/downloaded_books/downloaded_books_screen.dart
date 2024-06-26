import 'package:book_store/app/app_cubit/app_cubit.dart';
import 'package:book_store/cubits/downloaded_books/downloaded_books_cubit.dart';
import 'package:book_store/presentation/utils/constants/route_names.dart';
import 'package:book_store/presentation/utils/constants/color_const.dart';
import 'package:book_store/presentation/utils/my_icons.dart';
import 'package:book_store/presentation/views/tab_box/tabs/home/search_delegate/widget/suggestion_item.dart';
import 'package:book_store/presentation/widgets/no_books_item.dart';
import 'package:book_store/presentation/widgets/simple_app_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class DownloadedBooksScreen extends StatelessWidget {
  const DownloadedBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadedBooksCubit, DownloadedBooksState>(
      builder: (context, bookState) {
        return BlocBuilder<AppCubit, AppState>(
          buildWhen: (previous, current) {
            return previous.connectivityResult != current.connectivityResult;
          },
          builder: (context, appState) {
            return WillPopScope(
              onWillPop: () async =>
                  !(appState.connectivityResult == ConnectivityResult.none),
              child: Scaffold(
                backgroundColor: ColorConst.white,
                appBar: SimpleAppBar(
                  title: 'Downloaded books',
                  backButton:
                      !(appState.connectivityResult == ConnectivityResult.none),
                ),
                body: bookState.books.isEmpty
                    ? Center(
                        child: Lottie.asset(
                          MyIcons.noDownloadedBooksLottie,
                          reverse: true,
                        ),
                      )
                    : ListView(
                        children: List.generate(
                          bookState.books.length,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: SuggestionItem(
                              onSuggestionTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.bookDetail,
                                  arguments: bookState.books[index],
                                );
                              },
                              bookItem: bookState.books[index],
                            ),
                          ),
                        ),
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
