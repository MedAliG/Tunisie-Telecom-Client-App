import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt/objects/forfaitHis.dart';

class HistoriqueForfait extends StatefulWidget {
  _HistoriqueForfaitState createState() => _HistoriqueForfaitState();
}

class _HistoriqueForfaitState extends State<HistoriqueForfait> {
  ForfaitHList fh;
  Future<SharedPreferences> _userInfo = SharedPreferences.getInstance();
  int _state = 0;
  @override
  void initState() {
    _getForfaitHistory();
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
          color: Color(0xFFFFBF3A),
          image: DecorationImage(
              image: AssetImage('assets/wave-splash.png'), fit: BoxFit.cover),
        ),
        child: _setUp(),
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

  bodyContent() {
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
                  "Historique forfait",
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
          height: height * .065,
        ),
        Container(
          padding: EdgeInsets.only(left: width * .075),
          width: width,
          height: height * .07,
          child: Row(
            children: <Widget>[
              Text(
                "Historique",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'google',
                    fontSize: width * .06),
              )
            ],
          ),
        ),
        Container(
          height: height * .6,
          width: width,
          padding: EdgeInsets.only(left: width * .1, right: width * .1),
          child: ListView.builder(
            itemCount: fh.forfaits.length,
            itemBuilder: (BuildContext context, int index) {
              ForfaitH f = fh.forfaits[index];
              return _historyRow(index, f);
            },
          ),
        ),
        SizedBox(
          height: height * .02,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: width,
            height: height * .11,
            padding: EdgeInsets.only(top: height * .02, bottom: height * .02),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
                child: Center(
                  child: Text(
                    "X",
                    style: TextStyle(
                        fontFamily: 'googleB',
                        color: Colors.black54,
                        fontSize: height * .033),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  _historyRow(int index, ForfaitH f) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * .1,
      width: width * .8,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: (index != fh.forfaits.length - 1)
                      ? Colors.white
                      : Colors.transparent,
                  width: 2))),
      child: Row(
        children: <Widget>[
          Container(
            width: width * .55,
            padding: EdgeInsets.only(top: height * .01, bottom: height * .01),
            child: Container(
              decoration: BoxDecoration(
                  border:
                      Border(right: BorderSide(width: 2, color: Colors.white))),
              child: Center(
                  child: Text(
                f.date,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'googleM',
                    fontSize: width * .05),
              )),
            ),
          ),
          Container(
            width: width * .23,
            padding: EdgeInsets.only(
                top: height * .01, bottom: height * .01, left: width * .02),
            child: Center(
                child: Text(
              montantConvertion(f.montant),
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'googleM',
                  fontSize: width * .047),
            )),
          ),
        ],
      ),
    );
  }

  Future<void> _getForfaitHistory() async {
    final SharedPreferences prefs = await _userInfo;
    String userId = prefs.get("id");
    String url =
        "https://ttappss.000webhostapp.com/getForfaitHistory.php?token=5a773f9e8b9663b2918851ed6396feed63019b9a2f348cf69c9e96b3c0dbd960&userId=" +
            userId;
    http.Response res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    if (resBody['state'] == 'Success') {
      setState(() {
        fh = ForfaitHList.fromJson(resBody);
        for (int i = 0; i < fh.forfaits.length; i++) {
          fh.forfaits[i].date = fh.forfaits[i].convertDateToString();
        }
        _state = 1;
      });
    }
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
