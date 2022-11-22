import 'dart:io';

import 'package:book_store/constants/route_names.dart';
import 'package:book_store/data/models/author/author_model.dart';
import 'package:book_store/data/models/category/category_model.dart';
import 'package:book_store/views/auth/auth_screen.dart';
import 'package:book_store/views/author_book/author_book_screen.dart';
import 'package:book_store/views/book_detail/book_detail_screen.dart';
import 'package:book_store/views/category_book/category_book_screen.dart';
import 'package:book_store/views/main/main_screen.dart';
import 'package:book_store/views/on_boarding/main_on_boarding_screen.dart';
import 'package:book_store/views/pdf_viwer/pdf_viewer_screen.dart';
import 'package:book_store/views/splash/splash_screen.dart';
import 'package:book_store/views/tab_box/tab_box_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
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
      case RouteNames.mainOnBoarding:
        return MaterialPageRoute(
          builder: (_) => const MainOnBoardingScreen(),
        );
      case RouteNames.bookDetail:
        return MaterialPageRoute(
          builder: (_) =>
              BookDetailScreen(bookId: settings.arguments as String),
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
        var data = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
          builder: (_) => PDFViewerPage(
            file: data[0] as File,
            bookName: data[1] as String,
          ),
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
