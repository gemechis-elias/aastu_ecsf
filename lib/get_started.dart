import 'dart:developer';
import 'package:aastu_ecsf/route/auth_screen/login.dart';
import 'package:aastu_ecsf/route/home_screen/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:aastu_ecsf/model/get_started.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GetStarted extends StatelessWidget {
  final _pageController = PageController();

  final RecommendedModel recommendedModel = recommendations[0];

  GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor:
            Colors.transparent, // Replace with your desired status bar color
      ),
    );
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: Stack(
        children: <Widget>[
          /// PageView for Image
          PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            children: List.generate(
              recommendedModel.images.length,
              (int index) => Container(
                decoration: BoxDecoration(
                  color: const Color(0xff121212),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(recommendedModel.images[index]),
                  ),
                ),
              ),
            ),
          ),

          /// Content
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              color: const Color(0xff121212),
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.4,
                  maxHeight: MediaQuery.of(context).size.height * 0.5),
              padding: const EdgeInsets.only(
                  top: 70, left: 28.8, bottom: 48, right: 28.8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: recommendedModel.images.length,
                    effect: const ExpandingDotsEffect(
                        activeDotColor: Color(0xFFFFFFFF),
                        dotColor: Color(0xFFababab),
                        dotHeight: 4.8,
                        dotWidth: 6,
                        spacing: 4.8),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 19.2),
                    child: Text(
                      recommendedModel.tagLine,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontFamily: 'MyBoldFont',
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: [
                              Color(0xffd1a552),
                              Color.fromARGB(255, 209, 150, 82)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 19.2),
                    child: Text(
                      recommendedModel.description,
                      maxLines: 5,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontFamily: 'MyFont',
                        fontSize: MediaQuery.of(context).size.width * 0.037,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: [
                              Color(0xffd1a552),
                              Color.fromARGB(255, 178, 140, 101)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[],
                      ),
                      Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9.6),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xffd1a552),
                                Color.fromARGB(255, 209, 150, 82)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StreamBuilder<User?>(
                                    stream: FirebaseAuth.instance
                                        .authStateChanges(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<User?> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      }
                                      if (!snapshot.hasData) {
                                        log('No User Logged in!');
                                        return const LoginRoute();
                                      }
                                      log('User is signed in!');
                                      return const BottomNavigationBadgeRoute();
                                    },
                                  ),
                                ),
                              );
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 28.8, right: 28.8),
                                child: FittedBox(
                                  child: Text(
                                    'Get Started',
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// FavoriteButton Icon
class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;
  @override
  void dispose() {
    // Check if the widget is still mounted before accessing the context
    if (mounted) {
      // Restore system UI overlays when the widget is disposed
      SystemChrome.restoreSystemUIOverlays();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 57.6,
        width: 57.6,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.6),
          color: const Color(0x10000000),
        ),
        child: SvgPicture.asset(isFavorite
            ? 'assets/svg/icon_heart_fill_red.svg'
            : 'assets/svg/icon_heart_fill.svg'),
      ),
      onTap: () {
        log('Sebelum klik tombol => $isFavorite');
        setState(() {
          isFavorite = !isFavorite;
          log('Setelah klik tombol => $isFavorite');
        });
      },
    );
  }
}
