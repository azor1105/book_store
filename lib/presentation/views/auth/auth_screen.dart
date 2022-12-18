import 'package:book_store/presentation/views/auth/login/login_screen.dart';
import 'package:book_store/presentation/views/auth/sign_up/sign_up_screen.dart';
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
    return isLogged
        ? LoginScreen(
            switchAuthPages: switchAuthPages,
          )
        : SignUpScreen(
            switchAuthPages: switchAuthPages,
          );
  }

  void switchAuthPages() => setState(
        () {
          isLogged = !isLogged;
        },
        
      );
}
