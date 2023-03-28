import 'package:aastu_ecsf/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:aastu_ecsf/data/img.dart';

class LoginSimpleDarkRoute extends StatefulWidget {
  LoginSimpleDarkRoute();

  @override
  LoginSimpleDarkRouteState createState() => new LoginSimpleDarkRouteState();
}

class LoginSimpleDarkRouteState extends State<LoginSimpleDarkRoute> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar:
          PreferredSize(child: Container(), preferredSize: Size.fromHeight(0)),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            const Spacer(),
            Container(
              child: Image.asset(
                Img.get('logo_small_round.png'),
                color: Colors.green[300],
              ),
              width: 80,
              height: 80,
            ),
            Container(height: 15),
            TextField(
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.blueGrey[400]),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.blueGrey[400]!, width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.blueGrey[400]!, width: 2),
                ),
              ),
            ),
            Container(height: 25),
            TextField(
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.blueGrey[400]),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.blueGrey[400]!, width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.blueGrey[400]!, width: 2),
                ),
              ),
            ),
            Container(height: 5),
            Row(
              children: <Widget>[
                Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.transparent,
                  ),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.blueGrey[400]),
                  ),
                  onPressed: () {},
                )
              ],
            ),
            Container(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[300],
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20)),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavigationBadgeRoute()),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(primary: Colors.transparent),
                child: Text(
                  "New user? Sign Up",
                  style: TextStyle(color: Colors.green[300]),
                ),
                onPressed: () {},
              ),
            ),
            const Spacer(),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}
