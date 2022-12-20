import 'package:book_store/data/local_data/local_data.dart';
import 'package:book_store/presentation/utils/my_colors.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/app.dart';
import 'data/service/hive/models/downloaded_book/downloaded_book_model.dart';
import 'presentation/utils/constants/hive_constants.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DownloadedBookModelAdapter());
  await Hive.openBox<DownloadedBookModel>(HiveConstants.downloadedBookBox);
  await StorageRepository.getInstance();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: MyColors.white,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));
  runApp(const App());
}

