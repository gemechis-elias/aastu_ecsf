import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';

class ResetPasswordDarkRoute extends StatefulWidget {
  const ResetPasswordDarkRoute({super.key});

  @override
  ResetPasswordDarkRouteState createState() => ResetPasswordDarkRouteState();
}

class ResetPasswordDarkRouteState extends State<ResetPasswordDarkRoute> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff1F1F1F),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(),
      ),
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
                labelText: "Enter your email",
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
            Container(height: 5),
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
                  "Reset Password",
                  style: TextStyle(fontFamily: 'MyFont', color: Colors.black),
                ),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(
                      email: _emailController.text,
                    )
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Password reset email sent.',
                              style: TextStyle(
                                fontFamily: 'MyFont',
                              )),
                          backgroundColor: Colors.green,
                        ),
                      );
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Password reset failed.',
                            style: TextStyle(
                              fontFamily: 'MyFont',
                            )),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ),
            const Spacer(),
            Container(
              height: 170,
            )
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
