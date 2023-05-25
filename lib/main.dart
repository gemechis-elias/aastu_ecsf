import 'dart:async';
import 'dart:developer';
import 'package:aastu_ecsf/login.dart';
import 'package:aastu_ecsf/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';
import 'data/img.dart';
import 'data/sqlite_db.dart';
import 'main_bottom_nav.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // Application has Started
  log("Application has Started");
  final fcmToken = await FirebaseMessaging.instance.getToken();
  log("FCM Token: $fcmToken");
  runApp(ChangeNotifierProvider(
    create: (_) => UserProvider(),
    child: const MyApp(),
  ));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message: ${message.messageId}");
  // Handle the background message here
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

// function for final fcmToken = await FirebaseMessaging.instance.getToken();
// to get the token
void getFCMToken() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  log("FCM Token: $fcmToken");
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void initState() {
    super.initState();
    _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Received notification: ${message.notification?.title ?? ''}');
      // Handle the received notification here
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('Opened app from notification: ${message.notification?.title ?? ''}');
      // Handle the notification when the app is opened from the notification
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: const Color(0xff121212),
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: const Color(0xff121212),
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
        title: 'AASTU ECSF',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          textTheme: AppTheme.textTheme,
          platform: TargetPlatform.iOS,
        ),
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
                  log('User is currently signed out!');
                  // TODO: return the widget for the login screen

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

    startTime();
  }

  @override
  Widget build(BuildContext context) {
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
