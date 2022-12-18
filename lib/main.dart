import 'package:book_store/cubits/connectivity/connectivity_cubit.dart';
import 'package:book_store/cubits/download/download_cubit.dart';
import 'package:book_store/data/service/hive/hive_service.dart';
import 'package:book_store/data/service/models/downloaded_book/downloaded_book_model.dart';
import 'package:book_store/presentation/utils/constants/route_names.dart';
import 'package:book_store/data/local_data/local_data.dart';
import 'package:book_store/providers/auth_provider.dart';
import 'package:book_store/providers/author_provider.dart';
import 'package:book_store/providers/book_provider.dart';
import 'package:book_store/providers/category_provider.dart';
import 'package:book_store/providers/saved_book_provider.dart';
import 'package:book_store/presentation/utils/my_colors.dart';
import 'package:book_store/presentation/views/no_internet/no_internet_screen.dart';
import 'package:book_store/presentation/router/router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'presentation/utils/constants/hive_constants.dart';
import 'presentation/utils/constants/shared_pref_keys.dart';
import 'presentation/views/auth/auth_screen.dart';
import 'presentation/views/on_boarding/main_on_boarding_screen.dart';
import 'presentation/views/tab_box/tab_box_screen.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DownloadCubit(
            dio: Dio(),
            hiveService: HiveService(),
          ),
        ),
      ],
      child: MultiProvider(
        providers: [
          Provider<SavedBookProvider>(
            create: (context) => SavedBookProvider(firestore: firestore),
          ),
          Provider<CategoryProvider>(
            create: (context) => CategoryProvider(firestore: firestore),
          ),
          Provider<AuthorProvider>(
            create: (context) => AuthorProvider(firebaseFirestore: firestore),
          ),
          Provider<BookProvider>(
            create: (context) => BookProvider(firestore: firestore),
          ),
          Provider<AuthProvider>(
            create: (_) => AuthProvider(auth: FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) => context.read<AuthProvider>().authState,
            initialData: null,
          ),
          StreamProvider(
            create: (context) => context.read<AuthProvider>().userInfoChanges,
            initialData: null,
          ),
        ],
        child: ScreenUtilInit(
          splitScreenMode: true,
          minTextAdapt: true,
          designSize: const Size(375, 812),
          builder: (context, child) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              onGenerateRoute: Routes.generateRoute,
              initialRoute: RouteNames.splash,
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
    final firebaseUser = context.watch<User?>();
    return BlocProvider(
      create: (context) => ConnectivityCubit(),
      child: BlocBuilder<ConnectivityCubit, ConnectivityState>(
        buildWhen: (previous, current) =>
            previous.connectivityResult != current.connectivityResult ||
            firebaseUser?.uid == null,
        builder: (context, state) {
          if (state.connectivityResult == ConnectivityResult.none) {
            return const NoInternetScreen();
          } else if (StorageRepository.getBool(
                  keyOfValue: SharedPrefKeys.showOnBoarding) ==
              null) {
            return const MainOnBoardingScreen();
          } else if (firebaseUser?.uid != null) {
            return const TabBoxScreen();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}
