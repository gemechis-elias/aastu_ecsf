import 'dart:async';
import 'package:aastu_ecsf/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_theme.dart';
import 'data/img.dart';
import 'data/my_colors.dart';
import 'data/sqlite_db.dart';
import 'main_screen.dart';
import 'widget/my_text.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
        title: 'Flutter UI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: AppTheme.textTheme,
          platform: TargetPlatform.iOS,
        ),
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/MenuRoute': (BuildContext context) => new LoginSimpleDarkRoute(),
        });
  }
}

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, navigationPage);
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
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: Container(
          width: 125,
          height: 150,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                child: Image.asset(Img.get('logo_small_round.png'),
                    color: Colors.grey[800], fit: BoxFit.cover),
              ),
              Container(height: 20),
              Text("AASTU ECSF",
                  style: MyText.headline(context)!.copyWith(
                      color: Colors.grey[800],
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
              Container(height: 30),
              Container(
                height: 5,
                width: 80,
                child: LinearProgressIndicator(
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      MyColors.primaryLight),
                  backgroundColor: Colors.grey[300],
                ),
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
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
