import 'package:flutter/material.dart';
import 'package:tt/objects/users.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Info extends StatefulWidget {
  _InfoState createState() => new _InfoState();
}

class _InfoState extends State<Info> {
  Future<SharedPreferences> _userInfo = SharedPreferences.getInstance();
  String number;
  int _state = 0;

  UserData userInfo;

  @override
  void initState() {
    _setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Hero(
        tag: 'info',
        child: Material(
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Color(0xFF6ACFF6),
              image: DecorationImage(
                  image: AssetImage('assets/waves-home.png'),
                  fit: BoxFit.cover),
            ),
            child: _initScreen(),
          ),
        ),
      ),
    );
  }

  _initScreen() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (_state == 0) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: height * .83,
          ),
          Center(
              child: CircularProgressIndicator(
            value: null,
            strokeWidth: 5.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )),
        ],
      );
    } else {
      return _setUp();
    }
  }

  _setUp() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        SizedBox(
          height: height * .09,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Sold et Infos.",
              style: TextStyle(
                  fontFamily: 'googleB',
                  color: Colors.white,
                  fontSize: width * .06),
            )
          ],
        ),
        SizedBox(
          height: height * .08,
        ),
        Container(
          //height: height * .15,
          width: width,
          margin: EdgeInsets.only(left: width * .075, right: width * .075),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.white, width: 2))),
          child: Row(
            children: <Widget>[
              Container(
                width: width * .4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Sold",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'google',
                              fontSize: width * .05),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: height * .075,
                          width: width * .4,
                          padding: EdgeInsets.only(right: width * .008),
                          child: Text(
                            userInfo.sold + " DT",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'googleB',
                                color: Colors.white,
                                fontSize: width * .08),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * .015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          userInfo.finSold + " jours restant",
                          style: TextStyle(
                            fontFamily: 'googleb',
                            fontSize: width * .04,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * .04,
                    ),
                  ],
                ),
              ),
              Container(
                width: width * .05,
              ),
              Container(
                width: width * .4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Bonus sold",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'google',
                              fontSize: width * .04),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: height * .075,
                          width: width * .4,
                          padding: EdgeInsets.only(right: width * .008),
                          child: Text(
                            userInfo.bonus + " DT",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'googleB',
                                color: Colors.white,
                                fontSize: width * .08),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * .015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          userInfo.finBonus + " jours restant",
                          style: TextStyle(
                            fontFamily: 'googleb',
                            fontSize: width * .04,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * .04,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * .1,
        ),
        Container(
          //height: height * .15,
          width: width,
          margin: EdgeInsets.only(left: width * .125, right: width * .125),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.white, width: 2))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Forfait internet",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'google',
                        fontSize: width * .05),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: height * .075,
                    width: width * .75,
                    padding: EdgeInsets.only(right: width * .008),
                    child: Text(
                      montantConvertion(userInfo.soldInternet) ,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'googleB',
                          color: Colors.white,
                          fontSize: width * .1),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    userInfo.finSoldInternet + " jours restant",
                    style: TextStyle(
                      fontFamily: 'googleb',
                      fontSize: width * .045,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .04,
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * .15,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  child: Center(
                    child: Image(
                      image: AssetImage('assets/icons/dollar_signe.png'),
                    ),
                  ),
                  height: height * .075,
                  width: height * .075,
                  padding: EdgeInsets.only(
                      top: height * .015,
                      left: height * .015,
                      bottom: height * .015,
                      right: height * .015),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 5)
                      ]),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _setData() async {
    final SharedPreferences prefs = await _userInfo;
    number = prefs.get("phone");
    String url =
        "https://ttappss.000webhostapp.com/getUserData.php?token=5a773f9e8b9663b2918851ed6396feed63019b9a2f348cf69c9e96b3c0dbd960&phone=" +
            number;
    print(url);
    http.Response res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var resBody = json.decode(res.body);
    print(resBody['state']);
    setState(() {
      print(resBody['Result']['sold']);
      userInfo = new UserData.fromJson(resBody['Result']);
      _state = 1;
    });
  }

  String montantConvertion(String m) {
    int mm = int.parse(m);
    if (mm >= 1024) {
      double ret = mm / 1024;
      return ret.toStringAsFixed(2) + "Go";
    } else {
      return m + "Mo";
    }
  }
}
