import 'package:book_store/data/local_data/local_data.dart';
import 'package:book_store/presentation/utils/constants/shared_pref_keys.dart';
import 'package:book_store/presentation/views/auth/login/login_screen.dart';
import 'package:book_store/presentation/views/auth/sign_up/sign_up_screen.dart';
import 'package:book_store/presentation/views/on_boarding/main_on_boarding_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogged = true;

  @override
  Widget build(BuildContext context) {
    if (StorageRepository.getBool(keyOfValue: SharedPrefKeys.showOnBoarding) ==
        null) {
      return MainOnBoardingScreen(
        saveWatched: () {
          setState(() {
            StorageRepository.putBool(
                key: SharedPrefKeys.showOnBoarding, value: true);
          });
        },
      );
    }
    return isLogged
        ? LoginScreen(
            switchAuthPages: switchAuthPages,
          )
        : SignUpScreen(
            switchAuthPages: switchAuthPages,
          );
  }

  void switchAuthPages() => setState(() {
        isLogged = !isLogged;
      });
}
