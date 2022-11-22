import 'package:book_store/constants/shared_pref_keys.dart';
import 'package:book_store/data/local_data/local_data.dart';
import 'package:book_store/views/auth/auth_screen.dart';
import 'package:book_store/views/on_boarding/main_on_boarding_screen.dart';
import 'package:book_store/views/tab_box/tab_box_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (StorageRepository.getBool(
            keyOfValue: SharedPrefKeys.showOnBoarding) ==
        null) {
      return const MainOnBoardingScreen();
    } else if (firebaseUser?.uid != null) {
      return const TabBoxScreen();
    }
    return const AuthScreen();
  }
}
