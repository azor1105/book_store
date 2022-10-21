import 'package:book_store/constants/route_names.dart';
import 'package:book_store/data/local_data/local_data.dart';
import 'package:book_store/providers/auth_provider.dart';
import 'package:book_store/providers/author_provider.dart';
import 'package:book_store/providers/book_provider.dart';
import 'package:book_store/providers/category_provider.dart';
import 'package:book_store/providers/saved_book_provider.dart';
import 'package:book_store/utils/my_colors.dart';
import 'package:book_store/views/router/router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  await Firebase.initializeApp();
  FirebaseAppCheck firebaseAppCheck =  FirebaseAppCheck.instance;
  firebaseAppCheck.activate();
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
    return MultiProvider(
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
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: child,
            onGenerateRoute: Routes.generateRoute,
            initialRoute: RouteNames.splash,
          );
        },
      ),
    );
  }
}
