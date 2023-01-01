import 'package:book_store/data/local_data/local_data.dart';
import 'package:book_store/data/service/hive/downloaded_books_hive/models/downloaded_book/downloaded_book_model.dart';
import 'package:book_store/data/service/hive/saved_page_hive/models/saved_page_model.dart';
import 'package:book_store/presentation/utils/constants/color_const.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'app/app.dart';
import 'presentation/utils/constants/hive_constants.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();
  // Initializing Hive && Storage Service
  await Hive.initFlutter();
  Hive.registerAdapter(DownloadedBookModelAdapter());
  Hive.registerAdapter(SavedPageModelAdapter());
  await Hive.openBox<SavedPageModel>(HiveConstants.savedPageBox);
  await Hive.openBox<DownloadedBookModel>(HiveConstants.downloadedBookBox);
  await StorageRepository.getInstance();

  // Initializing Firebase 
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();

  // Setting portrait view on app && white status bar
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: ColorConst.white,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));

  // Running app
  runApp(const App());
}
