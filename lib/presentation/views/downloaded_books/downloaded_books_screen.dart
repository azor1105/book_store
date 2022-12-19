import 'package:book_store/cubits/connectivity/connectivity_cubit.dart';
import 'package:book_store/data/service/hive/hive_service.dart';
import 'package:book_store/presentation/utils/constants/route_names.dart';
import 'package:book_store/presentation/utils/my_colors.dart';
import 'package:book_store/presentation/views/tab_box/tabs/home/search_delegate/widget/suggestion_item.dart';
import 'package:book_store/presentation/widgets/no_books_item.dart';
import 'package:book_store/presentation/widgets/simple_app_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DownloadedBooksScreen extends StatelessWidget {
  const DownloadedBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var downloadedBooks = HiveService.getBooks()
        .values
        .toList()
        .map((e) => e.toBookModel())
        .toList();
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      buildWhen: (previous, current) {
        return previous.connectivityResult != current.connectivityResult;
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async =>
              !(state.connectivityResult == ConnectivityResult.none),
          child: Scaffold(
            backgroundColor: MyColors.white,
            appBar: SimpleAppBar(
              title: 'Downloaded books',
              backButton: !(state.connectivityResult == ConnectivityResult.none),
            ),
            body: downloadedBooks.isEmpty
                ? const NoBookItem()
                : ListView(
                    children: List.generate(
                      downloadedBooks.length,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SuggestionItem(
                          onSuggestionTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.bookDetail,
                              arguments: downloadedBooks[index],
                            );
                          },
                          bookItem: downloadedBooks[index],
                        ),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
