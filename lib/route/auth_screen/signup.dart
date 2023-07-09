// Copyright (c) 2023 Gemechis Elias
// This source code is licensed under the MIT license found in the LICENSE file in the root directory of this source tree.
import 'dart:developer';
import 'package:aastu_ecsf/route/auth_screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aastu_ecsf/route/home_screen/bottom_nav.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';

class SignUpRoute extends StatefulWidget {
  const SignUpRoute({super.key});

  @override
  SignUpRouteState createState() => SignUpRouteState();
}

class SignUpRouteState extends State<SignUpRoute> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ConfirmPasswordController =
      TextEditingController();

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
              child: Image.asset(Img.get('logo.png')),
            ),
            Container(height: 15),
            TextField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              style: const TextStyle(color: Color.fromARGB(242, 255, 255, 255)),
              decoration: const InputDecoration(
                labelText: "Full Name",
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
            Container(height: 25),
            const TextField(
              //   controller: _confirmPasswordController,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Confirm Password",
                labelStyle: TextStyle(color: Color(0xff808080)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff808080), width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff808080), width: 2),
                ),
              ),
            ),
            Container(height: 20),
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
                  "Sign Up",
                  style: TextStyle(fontFamily: 'MyFont', color: Colors.black),
                ),
                onPressed: () async {
                  try {
                    final UserCredential userCredential = await FirebaseAuth
                        .instance
                        .createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );

                    // save user id
                    log("User ID: ${userCredential.user!.uid}");
                    // save user data on database
                    final DatabaseReference userRef = FirebaseDatabase.instance
                        .ref()
                        .child('users/${userCredential.user!.uid}');
                    await userRef.set({
                      "name": _nameController.text.toString(),
                      "email": _emailController.text.toString(),
                      "role": "user",
                      "bio": "Add your bio here",
                      "photoUrl": "",
                      "department": "",
                      "batch": "",
                      "team": "",
                      "joinedDate": DateTime.now().toString().substring(0, 11),
                    });
                    // ignore: use_build_context_synchronously
                    final state = context.findAncestorStateOfType<State>();
                    if (state != null && state.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const BottomNavigationBadgeRoute(),
                        ),
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      log('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      log('The account already exists for that email.');
                    } else {
                      log('Error: ${e.code}');
                    }
                  } catch (e) {
                    log('Error: $e');
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
                  "Already Registered? Login",
                  style:
                      TextStyle(fontFamily: 'MyFont', color: Color(0xff808080)),
                ),
                onPressed: () {
                  // Handle the login button pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginRoute(),
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
