import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:tt/objects/forfait.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt/objects/users.dart';

class ForfaitScreen extends StatefulWidget {
  _ForfaitScreenState createState() => new _ForfaitScreenState();
}

class _ForfaitScreenState extends State<ForfaitScreen> {
  UserData userInfo;
  Future<SharedPreferences> _userInfo = SharedPreferences.getInstance();
  ForfaitList fl;
  int _selected = -1;
  int _state = 0;
  int _purchaseState = 1;
  String _purchaseErrMsg = "";
  int _proccState = 0;
  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Hero(
        tag: 'forfait',
        child: Material(
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Color(0xFFFFBF3A),
              image: DecorationImage(
                  image: AssetImage('assets/wave-splash.png'),
                  fit: BoxFit.cover),
            ),
            child: _setUp(),
          ),
        ),
      ),
    );
  }

  _setUp() {
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
    } else if (_state == 1) {
      return bodyContent();
    }
  }

  Column bodyContent() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        SizedBox(
          height: height * .09,
        ),
        Hero(
          tag: 'hero',
          
          child: Material(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Forfait Internet",
                  style: TextStyle(
                      fontFamily: 'googleB',
                      color: Colors.white,
                      fontSize: width * .06),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: height * .05,
        ),
        Container(
          height: height * .15,
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
                  Container(
                    alignment: Alignment.center,
                    height: height * .075,
                    width: width * .75,
                    padding: EdgeInsets.only(right: width * .008),
                    child: Text(
                      montantConvertion(userInfo.soldInternet),
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
                    "${userInfo.finSoldInternet} jours restant",
                    style: TextStyle(
                      fontFamily: 'googleb',
                      fontSize: width * .045,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: height * .07,
        ),
        Container(
          //height: height * .56,
          width: width,
          padding: EdgeInsets.only(right: width * .05, left: width * .05),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Acheter",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'google',
                        fontSize: width * .06),
                  )
                ],
              ),
              Container(
                height: height * .4,
                width: width * .9,
                child: ListView.builder(
                  itemCount: fl.forfaits.length,
                  itemBuilder: (BuildContext context, int index) {
                    Forfait f = fl.forfaits[index];
                    return _item(index, f);
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
            height: (_purchaseState != 1) ? height * .03 : 0,
            width: width,
            child: Center(
              child: Text(
                _purchaseErrMsg,
                style: TextStyle(
                    fontFamily: 'google',
                    color: (_purchaseState == -1)
                        ? Colors.redAccent
                        : Colors.green,
                    fontSize: width * .045),
              ),
            )),
        Container(
          height: height * .1,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: btnProg(height, width),
              )
            ],
          ),
        ),
      ],
    );
  }

  btnProg(height, width) {
    if (_proccState == 0) {
      return achatBtn(height, width);
    } else {
      return Container(
        child: Center(
            child: CircularProgressIndicator(
          value: null,
          strokeWidth: 5.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )),
      );
    }
  }

  achatBtn(double height, double width) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/histoForf');
          },
          child: Container(
            height: height * .065,
            width: width * .25,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
            child: Center(
              child: Text(
                "Hisotrique",
                style: TextStyle(
                    color: Color(0xFFFFBF3A),
                    fontFamily: 'googleB',
                    fontSize: width * .04),
              ),
            ),
          ),
        ),
        Container(
          width: width * .05,
        ),
        GestureDetector(
          onTap: () {
            if (_selected != -1) {
              setState(() {
                _proccState = 1;
              });
              _achatForfait(_selected.toString());
            }
          },
          child: Container(
            height: height * .065,
            width: width * .25,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
            child: Center(
              child: Text(
                "Acheter",
                style: TextStyle(
                    color: Color(0xFFFFBF3A),
                    fontFamily: 'googleB',
                    fontSize: width * .04),
              ),
            ),
          ),
        )
      ],
    );
  }

  _item(int index, Forfait f) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * .0875,
      width: width * .9,
      padding: EdgeInsets.only(bottom: height * .01),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selected = int.parse(f.id);
          });
        },
        child: Container(
          padding: EdgeInsets.only(left: width * .05, right: width * .05),
          decoration: BoxDecoration(
            color: (_selected == int.parse(f.id))
                ? Colors.white
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    montantConvertion(f.montant) + " (${f.duree}j)",
                    style: TextStyle(
                        fontFamily: 'googleB',
                        fontSize: width * .055,
                        color: (_selected == int.parse(f.id))
                            ? Colors.black
                            : Colors.white),
                  ),
                  Text(
                    "${f.prix} dt",
                    style: TextStyle(
                        fontFamily: 'googleB',
                        fontSize: width * .055,
                        color: (_selected == int.parse(f.id))
                            ? Colors.black
                            : Colors.white),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getData() async {
    final SharedPreferences prefs = await _userInfo;
    String number = prefs.get("phone");
    String url =
        "https://ttappss.000webhostapp.com/listForfaits.php?token=5a773f9e8b9663b2918851ed6396feed63019b9a2f348cf69c9e96b3c0dbd960";
    http.Response res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    if (resBody['state'] == 'Success') {
      String url2 =
          "https://ttappss.000webhostapp.com/getUserData.php?token=5a773f9e8b9663b2918851ed6396feed63019b9a2f348cf69c9e96b3c0dbd960&phone=" +
              number;
      //  print(url2);
      http.Response res2 = await http
          .get(Uri.encodeFull(url2), headers: {"Accept": "application/json"});
      var resBody2 = json.decode(res2.body);
      if (resBody2['state'] == 'Success') {
        setState(() {
          fl = ForfaitList.fromJson(resBody);
          userInfo = new UserData.fromJson(resBody2['Result']);
          _state = 1;
        });
      }
    }
  }

  Future<void> _achatForfait(String forfaitId) async {
    final SharedPreferences prefs = await _userInfo;
    String id = prefs.get("id");
    String url =
        "https://ttappss.000webhostapp.com/achatForfait.php?token=5a773f9e8b9663b2918851ed6396feed63019b9a2f348cf69c9e96b3c0dbd960&userId=" +
            id +
            "&forfaitId=" +
            forfaitId;
    print(url);
    http.Response res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    if (resBody['state'] == 'Success') {
      String number = prefs.get("phone");
      String url2 =
          "https://ttappss.000webhostapp.com/getUserData.php?token=5a773f9e8b9663b2918851ed6396feed63019b9a2f348cf69c9e96b3c0dbd960&phone=" +
              number;
      print(url2);
      
      http.Response res2 = await http
          .get(Uri.encodeFull(url2), headers: {"Accept": "application/json"});
      var resBody2 = json.decode(res2.body);
      setState(() {
        userInfo = new UserData.fromJson(resBody2['Result']);
        _purchaseErrMsg = "Achat effectué avec success";
        _proccState = 0;
        _purchaseState = 0;
      });
    } else if (resBody['state'] == "Sold Insuffisant") {
      setState(() {
        _purchaseErrMsg = "Sold Insuffisant";
        _proccState = 0;
        _purchaseState = -1;
      });
    } else {}
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
