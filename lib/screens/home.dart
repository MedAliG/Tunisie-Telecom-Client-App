import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<SharedPreferences> _serial = SharedPreferences.getInstance();
  String username = "";
  String phoneNumber = "";
  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Color(0xFF382586),
          image: DecorationImage(
              image: AssetImage('assets/waves-home.png'), fit: BoxFit.cover),
        ),
        child: Container(
          padding: EdgeInsets.only(left: width * .05, right: width * .05),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Colors.transparent),
                alignment: Alignment.centerRight,
                height: height * .1,
                width: width,
                child: GestureDetector(
                  onTap: () {
                    _disconnect();
                  },
                  child: Icon(
                    Icons.power_settings_new,
                    size: width * .07,
                    color: Colors.white54,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Text("+216 " + phoneNumber,
                      style: TextStyle(
                          fontFamily: 'googleM',
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 0))
                ],
              ),
              SizedBox(
                height: height * .01,
              ),
              Row(
                children: <Widget>[
                  Text(username,
                      style: TextStyle(
                          fontFamily: 'googleM',
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 0))
                ],
              ),
              SizedBox(
                height: height * .04,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Acceuil",
                    style: TextStyle(
                        fontFamily: 'googleM',
                        color: Colors.white,
                        fontSize: 34,
                        letterSpacing: 0),
                  ),
                ],
              ),
              SizedBox(
                height: height * .02,
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: height * .7,
                    width: width * .425,
                    //color: Colors.red,
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/creditRecharge');
                          },
                          child: Hero(
                            tag: 'Recharge',
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                height: height * .35,
                                width: width * .425,
                                decoration: BoxDecoration(
                                    color: Color(0xFFF85959),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.only(
                                    left: width * .04, top: height * .02),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(3),
                                          height: width * .12,
                                          width: width * .12,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 3)),
                                          child: Image(
                                              image: AssetImage(
                                                  'assets/icons/logo_recharge.png')),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * .075,
                                    ),
                                    Container(
                                      //color: Colors.red,
                                      margin:
                                          EdgeInsets.only(right: width * .05),
                                      child: Text(
                                        "Recharge de credit",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'googleM',
                                            fontSize: width * .065),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * .01,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "Service rapide",
                                          style:
                                              TextStyle(color: Colors.white70),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/creditTransfer');
                          },
                          child: Hero(
                            tag: 'TranferHero',
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                height: height * .25,
                                width: width * .425,
                                decoration: BoxDecoration(
                                    color: Color(0xFF8A3ADD),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.only(
                                    left: width * .04, top: height * .02),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(3),
                                          height: width * .12,
                                          width: width * .12,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 3)),
                                          child: Image(
                                              image: AssetImage(
                                                  'assets/icons/logo_transfer_credit.png')),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * .05,
                                    ),
                                    Container(
                                      //color: Colors.red,
                                      margin:
                                          EdgeInsets.only(right: width * .05),
                                      child: Text(
                                        "Transfer de credit",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'googleM',
                                            fontSize: width * .065),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: width * .05,
                  ),
                  Container(
                    height: height * .7,
                    width: width * .425,
                    //color: Colors.red,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: height * .03,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/info');
                          },
                          child: Hero(
                            tag: 'info',

                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                height: height * .35,
                                width: width * .425,
                                decoration: BoxDecoration(
                                    color: Color(0xFF6ACFF6),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.only(
                                    left: width * .04, top: height * .02),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(3),
                                          height: width * .12,
                                          width: width * .12,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 3)),
                                          child: Image(
                                              image: AssetImage(
                                                  'assets/icons/logo_informations.png')),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * .1,
                                    ),
                                    Container(
                                      //color: Colors.red,
                                      margin:
                                          EdgeInsets.only(right: width * .05),
                                      child: Text(
                                        "Solde et infos.",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'googleM',
                                            fontSize: width * .065),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/forfait');
                          },
                          child: Hero(
                            tag: 'forfait',
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                height: height * .25,
                                width: width * .425,
                                decoration: BoxDecoration(
                                    color: Color(0xFFFFBF3A),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.only(
                                    left: width * .04, top: height * .02),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(3),
                                          height: width * .12,
                                          width: width * .12,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 3)),
                                          child: Image(
                                              image: AssetImage(
                                                  'assets/icons/logo_forfait_internet.png')),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * .05,
                                    ),
                                    Container(
                                      //color: Colors.red,
                                      margin:
                                          EdgeInsets.only(right: width * .05),
                                      child: Text(
                                        "Forfait Internet",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'googleM',
                                            fontSize: width * .065),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _initData() async {
    final SharedPreferences prefs = await _serial;
    setState(() {
      username = prefs.get("fullName");
      phoneNumber = prefs.get("phone");
    });
  }

  Future<void> _disconnect() async {
    final SharedPreferences prefs = await _serial;
    prefs.clear();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }
}
