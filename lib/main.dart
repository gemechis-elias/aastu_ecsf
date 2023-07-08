// Copyright (c) 2023 Written by Gemechis Elias
import 'dart:async';
import 'dart:developer';
import 'package:aastu_ecsf/route/auth_screen/login.dart';
import 'package:aastu_ecsf/route/user/change_profile.dart';
import 'package:aastu_ecsf/route/user/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'app_theme.dart';
import 'data/img.dart';
import 'data/sqlite_db.dart';
import 'route/home_screen/bottom_nav.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      await serviceWorkerController
          .setServiceWorkerClient(AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          log(request.toString());
          return null;
        },
      ));
    }
  }
  await Firebase.initializeApp();
  enableDatabasePersistence();

  await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp]);
  // Application has Started
  log("Application has Started");
  runApp(
    const MyApp(),
  );
}

void enableDatabasePersistence() {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  database.setPersistenceEnabled(true);
  database.setPersistenceCacheSizeBytes(10000000); // 10MB
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData currentTheme = ThemeData.dark();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          Brightness.light == Brightness.dark ? Colors.white : Colors.black,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.dark,
      systemNavigationBarColor:
          Brightness.light == Brightness.dark ? Colors.white : Colors.black,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    log("Building MyApp widget");

    return MaterialApp(
        title: 'AASTU ECSF',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: const SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/MenuRoute': (BuildContext context) {
            return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (!snapshot.hasData) {
                  log('No User Logged in!');

                  return const LoginRoute();
                }
                log('User is signed in!');
                return const BottomNavigationBadgeRoute();
              },
            );
          },
          '/ProfileRoute': (context) => const UserProfileRoute(),
        });
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/MenuRoute');
  }

  @override
  void initState() {
    super.initState();
    SQLiteDb dbHelper = SQLiteDb();
    dbHelper.init();

    log("Initializing SplashScreen widget");

    startTime();
  }

  @override
  Widget build(BuildContext context) {
    log("Building SplashScreen widget");

    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          width: 150,
          height: 150,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 300,
                height: 70,
                child: Image.asset(Img.get('logo.png')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
