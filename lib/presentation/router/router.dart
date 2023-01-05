import 'package:book_store/app/app.dart';
import 'package:book_store/data/models/book/book_model.dart';
import 'package:book_store/presentation/utils/constants/route_names.dart';
import 'package:book_store/data/models/author/author_model.dart';
import 'package:book_store/data/models/category/category_model.dart';
import 'package:book_store/presentation/views/auth/auth_screen.dart';
import 'package:book_store/presentation/views/author_book/view/author_book_screen.dart';
import 'package:book_store/presentation/views/book_detail/book_detail_screen.dart';
import 'package:book_store/presentation/views/category_book/view/category_book_screen.dart';
import 'package:book_store/presentation/views/tab_box/tabs/saved/views/downloaded_books/downloaded_books_screen.dart';
import 'package:book_store/presentation/views/no_internet/no_internet_screen.dart';
import 'package:book_store/presentation/views/pdf_viewer/pdf_viewer_screen.dart';
import 'package:book_store/presentation/views/tab_box/tab_box_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.downloadedBooks:
        return MaterialPageRoute(
          builder: (_) => const DownloadedBooksScreen(),
        );
      case RouteNames.noInternet:
        return MaterialPageRoute(
          builder: (_) => const NoInternetScreen(),
        );
      case RouteNames.main:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
        );
      case RouteNames.auth:
        return MaterialPageRoute(
          builder: (_) => const AuthScreen(),
        );
      case RouteNames.tabBox:
        return MaterialPageRoute(
          builder: (_) => const TabBoxScreen(),
        );
      case RouteNames.bookDetail:
        return MaterialPageRoute(
          builder: (_) {
            return BookDetailScreen(
              bookModel: settings.arguments as BookModel,
            );
          },
        );
      case RouteNames.categoryBook:
        return MaterialPageRoute(
          builder: (_) => CategoryBookScreen(
              categoryModel: settings.arguments as CategoryModel),
        );
      case RouteNames.authorBook:
        return MaterialPageRoute(
          builder: (_) => AuhtorBookScreen(
            author: settings.arguments as AuthorModel,
          ),
        );
      case RouteNames.pdfView:
        return MaterialPageRoute(
          builder: (_) {
            List<dynamic> args = settings.arguments as List<dynamic>;
            return PdfViewerScreen(
              bookModel: args[0] as BookModel,
              bookPath: args[1] as String?,
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("404 page not found"),
            ),
          ),
        );
    }
  }
}
