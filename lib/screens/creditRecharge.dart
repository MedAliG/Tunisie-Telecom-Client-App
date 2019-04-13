import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:tt/objects/recharge.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RechargeCredit extends StatefulWidget {
  _RechargeCreditState createState() => new _RechargeCreditState();
}

class _RechargeCreditState extends State<RechargeCredit> {
  RechargeList rl;
  int _state = 0;
  Future<SharedPreferences> _userInfo = SharedPreferences.getInstance();
  @override
  void initState() {
    _getRechargeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _setUp(),
    );
  }

  _setUp() {
    if (_state == 0) {
      return _loading();
    } else if (_state == 1) {
      return _body();
    }
  }

  _loading() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Material(
      elevation: 0,
      child: Container(
        color: Color(0xFFF2F2F2),
        height: height,
        width: width,
        child: ListView(
          //shrinkWrap: true,
          children: <Widget>[
            Material(
              child: Hero(
                tag: 'Recharge',
                child: Container(
                  height: height * .6,
                  width: width,
                  decoration: BoxDecoration(
                      color: Color(0xFFF85959),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 5)
                      ]),
                ),
              ),
            ),
            Container(
              height: height * .35,
              width: width,
              child: Center(
                child: CircularProgressIndicator(
                  value: null,
                  strokeWidth: 5.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF85959)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _body() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Color(0xFFF2F2F2),
      height: height,
      width: width,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Hero(
            tag: 'Recharge',
            child: Material(
              child: Container(
                height: height * .58,
                width: width,
                decoration: BoxDecoration(
                    color: Color(0xFFF85959),
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: height * .09,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Recharge de credit",
                          style: TextStyle(
                              fontFamily: 'googleB',
                              color: Colors.white,
                              fontSize: width * .06),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * .1,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          width: width * .7,
                          margin: EdgeInsets.only(left: width * .15),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: width * .7,
                                padding: EdgeInsets.only(left: width * .02),
                                child: Text(
                                  "Saisir le code",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'google',
                                      fontSize: width * .04),
                                ),
                              ),
                              SizedBox(
                                height: height * .01,
                              ),
                              Container(
                                height: height * .05,
                                width: width * .7,
                                padding: EdgeInsets.only(
                                  left: width * .075,
                                  right: width * .075,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7)),
                                child: Center(
                                  child: TextField(
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: width * .05),
                                    decoration: new InputDecoration.collapsed(
                                        hintText: "XXX-XXX-XXXX-XXXX",
                                        hintStyle: TextStyle(
                                            color: Colors.black54,
                                            fontSize: width * .05)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * .08,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            height: height * .1,
                            width: height * .1,
                            padding: EdgeInsets.all(height * .02),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/icons/qr-code.png'),
                                      fit: BoxFit.contain)),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * .05,
          ),
          Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: width * .1),
                  child: Text(
                    "Historique",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: width * .065,
                        fontFamily: 'googleB'),
                  ))
            ],
          ),
          SizedBox(
            height: height * .03,
          ),
          Container(
            height: height * .13 * 2,
            margin: EdgeInsets.only(bottom: height * .03),
            padding: EdgeInsets.only(left: width * .025, right: width * .025),
            child: ListView.builder(
              itemCount: rl.recharges.length,
              itemBuilder: (BuildContext context, int index) {
                SingleRecharge rech = rl.recharges[index];
                return _singleHistory(rech);
              },
            ),
          ),
        ],
      ),
    );
  }

  _singleHistory(SingleRecharge rech) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: height * .02),
      height: height * .11,
      width: width * .95,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: <Widget>[
          Container(
            width: width * .725,
            height: height * .11,
            //color: Colors.red,
            padding: EdgeInsets.only(left: width * .02, right: width * .02),
            child: Center(
              child: Text(
                rech.date,
                style: TextStyle(fontFamily: 'googleM', fontSize: width * .053),
              ),
            ),
          ),
          Container(
            width: width * .225,
            height: height * .11,
            child: Center(
              child: Container(
                height: height * .08,
                width: width * .18,
                decoration: BoxDecoration(
                    color: Color(0xFFF85959),
                    borderRadius: BorderRadius.circular(6)),
                child: Center(
                  child: Text(
                    "${rech.montant}dt",
                    style:
                        TextStyle(color: Colors.white, fontSize: width * .055),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _getRechargeData() async {
    final SharedPreferences prefs = await _userInfo;
    String userId = prefs.get("id");
    String url =
        "https://ttappss.000webhostapp.com/getRechargeHistory.php?token=5a773f9e8b9663b2918851ed6396feed63019b9a2f348cf69c9e96b3c0dbd960&userId=" +
            userId;
    http.Response res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    if (resBody['state'] == 'Success') {
      setState(() {
        rl = RechargeList.fromJson(resBody);
        for (int i = 0; i < rl.recharges.length; i++) {
          rl.recharges[i].date = rl.recharges[i].convertDateToString();
        }
        _state = 1;
      });
    } else {
      setState(() {
        _state = -1;
      });
    }
  }
}
