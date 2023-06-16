// Copyright (c) 2023 Gemechis Elias
// This source code is licensed under the MIT license found in the LICENSE file in the root directory of this source tree.
import 'dart:async';
import 'dart:developer';
import 'package:aastu_ecsf/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'data/img.dart';
import 'data/sqlite_db.dart';
import 'main_bottom_nav.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  enableDatabasePersistence();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

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
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
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

                  return LoginSimpleDarkRoute();
                }
                log('User is signed in!');
                return BottomNavigationBadgeRoute();
              },
            );
          },
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
