import 'dart:developer';
import 'package:aastu_ecsf/route/home_screen/bottom_nav.dart';
import 'package:aastu_ecsf/route/auth_screen/forget_password.dart';
import 'package:aastu_ecsf/route/auth_screen/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute({super.key});

  @override
  LoginRouteState createState() => LoginRouteState();
}

class LoginRouteState extends State<LoginRoute> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff1F1F1F),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0), child: Container()),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Spacer(),
            SizedBox(
              width: 140,
              height: 140,
              child: Image.asset(
                Img.get('logo.png'),
              ),
            ),
            Container(height: 15),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Color(0xff808080)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff808080), width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff808080), width: 2),
                ),
              ),
            ),
            Container(height: 25),
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Color(0xff808080)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff808080), width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff808080), width: 2),
                ),
              ),
            ),
            Container(height: 5),
            Row(
              children: <Widget>[
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.transparent,
                  ),
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                        fontFamily: 'MyFont', color: Color(0xff808080)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetPasswordDarkRoute(),
                      ),
                    );
                  },
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffD1A522),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontFamily: 'MyFont', color: Colors.black),
                ),
                onPressed: () async {
                  // signIn
                  try {
                    final credential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );

                    // save user id
                    log("User ID: ${credential.user!.uid}");
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const BottomNavigationBadgeRoute(),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      log('No user found for that email.');

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No user found for that email.',
                              style: TextStyle(
                                fontFamily: 'MyFont',
                              )),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (e.code == 'wrong-password') {
                      log('Email or Password is incorrect.');

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Email or Password is incorrect.',
                              style: TextStyle(
                                fontFamily: 'MyFont',
                              )),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style:
                    TextButton.styleFrom(foregroundColor: Colors.transparent),
                child: const Text(
                  "New user? Sign Up",
                  style:
                      TextStyle(fontFamily: 'MyFont', color: Color(0xff808080)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpRoute(),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
