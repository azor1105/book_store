import 'package:book_store/app/app_cubit/app_cubit.dart';
import 'package:book_store/cubits/book/book_cubit.dart';
import 'package:book_store/cubits/downloaded_books/downloaded_books_cubit.dart';
import 'package:book_store/data/local_data/local_data.dart';
import 'package:book_store/data/repositories/auth_repository.dart';
import 'package:book_store/data/repositories/book_repository.dart';
import 'package:book_store/presentation/router/router.dart';
import 'package:book_store/presentation/utils/constants/shared_pref_keys.dart';
import 'package:book_store/presentation/views/auth/auth_screen.dart';
import 'package:book_store/presentation/views/no_internet/no_internet_screen.dart';
import 'package:book_store/presentation/views/on_boarding/main_on_boarding_screen.dart';
import 'package:book_store/presentation/views/tab_box/tab_box_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
            auth: FirebaseAuth.instance,
          ),
        ),
        RepositoryProvider(
          create: (context) => FirebaseFirestore.instance,
        ),
        RepositoryProvider(
          create: (context) => BookRepository(
            firestore: context.read<FirebaseFirestore>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DownloadedBooksCubit()..getBooks(),
          ),
          BlocProvider(
            create: (context) => AppCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => BookCubit(
              bookRepository: BookRepository(
                firestore: context.read<FirebaseFirestore>(),
              ),
            )..getBooks(),
          ),
        ],
        child: ScreenUtilInit(
          splitScreenMode: true,
          minTextAdapt: true,
          designSize: const Size(375, 812),
          builder: (context, child) {
            return const MaterialApp(
              restorationScopeId: "root",
              debugShowCheckedModeBanner: false,
              onGenerateRoute: Routes.generateRoute,
              home: MainScreen(),
            );
          },
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        if (state.connectivityResult == ConnectivityResult.none) {
          return const NoInternetScreen();
        } else if (StorageRepository.getBool(
                keyOfValue: SharedPrefKeys.showOnBoarding) ==
            null) {
          return const MainOnBoardingScreen();
        } else if (state.userStatus == UserStatus.authenticated) {
          return const TabBoxScreen();
        }
        return const AuthScreen();
      },
    );
  }
}
