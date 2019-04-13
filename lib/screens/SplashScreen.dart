import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<SharedPreferences> _serial = SharedPreferences.getInstance();

  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => _checkLogginStatus());
  }

  Future<void> _checkLogginStatus() async {
    final SharedPreferences prefs = await _serial;
    if (prefs.get("phone") != null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/home", (Route<dynamic> route) => false);
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF382586),
          image: DecorationImage(
              image: AssetImage('assets/wave-splash.png'), fit: BoxFit.cover),
        ),
        height: height,
        width: width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: height * .1,
                width: width * .18,
                decoration: BoxDecoration(
                    //color: Colors.red,
                    image: DecorationImage(
                        image: AssetImage('assets/icons/tt_logo.png'))),
              ),
              Container(
                child: Text(
                  "TT Client",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'google',
                      fontSize: width * .055),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
