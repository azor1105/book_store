import 'package:book_store/data/repositories/book_repository.dart';
import 'package:book_store/presentation/utils/constants/route_names.dart';
import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/presentation/utils/my_fonts.dart';
import 'package:book_store/presentation/views/tab_box/tabs/home/search_delegate/widget/result_book_item.dart';
import 'package:book_store/presentation/views/tab_box/tabs/home/search_delegate/widget/suggestion_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/constants/color_const.dart';
import '../../../../../utils/my_icons.dart';

class SearchDelegateScreen extends SearchDelegate {
  BookModel? resultBookItem;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = "";
            resultBookItem = null;
          }
        },
        icon: const Icon(
          Icons.clear,
          color: ColorConst.black,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: SvgPicture.asset(
        MyIcons.arrowBackIcon,
        color: ColorConst.black,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return query == resultBookItem?.bookName
        ? ResultBookItem(
            resultBookItem: resultBookItem!,
            onTap: () {
              close(context, null);

              Navigator.pushNamed(
                context,
                RouteNames.bookDetail,
                arguments: resultBookItem,
              );
            },
          )
        : Center(
            child: Text(
              "No selected book",
              style: MyFonts.w500,
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query != ""
        ? StreamBuilder<List<BookModel>>(
            stream: context
                .read<BookRepository>()
                .getBooksBySearchText(searchText: query.toLowerCase()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<BookModel> suggestedBooks = snapshot.data!;
                return ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    itemCount: suggestedBooks.length,
                    itemBuilder: (context, index) {
                      var bookItem = suggestedBooks[index];
                      return SuggestionItem(
                        onSuggestionTap: () {
                          resultBookItem = bookItem;
                          query = bookItem.bookName;
                        },
                        bookItem: bookItem,
                      );
                    });
              } else {
                return const SizedBox();
              }
            },
          )
        : const SizedBox();
  }
}
