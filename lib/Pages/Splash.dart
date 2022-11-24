import 'package:flutter/material.dart';
import 'package:gametest/Pages/Dashboard.dart';
import 'package:gametest/Pages/Login.dart';
// import 'package:lotteryapp/Pages/Dashboard.dart';
import 'dart:async';

// import 'package:lotteryapp/Pages/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _checklogin();
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  startTimeloginscreen() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route2);
  }

  route() {
    Navigator.of(context).popAndPushNamed(Login.routename);
  }

  route2() {
    Navigator.of(context).popAndPushNamed(Dashboard.routename);
  }

  Future _checklogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var name = preferences.getString('email');
    if (name == null) {
      startTime();
    } else {
      startTimeloginscreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xff07459c),
          image: DecorationImage(
            image: AssetImage("assets/Images/Background.png"),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/Images/Lottery-Logo.png'),
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
