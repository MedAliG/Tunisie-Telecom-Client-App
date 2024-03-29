import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt/screens/register.dart';
import 'package:clippy_flutter/clippy_flutter.dart';

class Login extends StatefulWidget {
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  Future<SharedPreferences> _serial = SharedPreferences.getInstance();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  String errorMessage = "";
  int _state = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Widget loginButton() {
      if (_state == 0) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _state = 1;
                    });
                    getData();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.1, 0.5, 0.7, 0.9],
                            colors: [
                              /*Color(0xFF8C30F6),
                                    Color(0xFF8C30F6),
                                    Color(0xFF8C30F6),
                                    Color(0xFF8C30F6),*/
                              Color(0XFF34588F),
                              Color(0xFF386FB5),
                              Color(0XFF3CA3C3),
                              Color(0xFF49B1E3),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Login  ",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                          Icon(
                            IconData(0xe5e1,
                                fontFamily: 'MaterialIcons',
                                matchTextDirection: true),
                            color: Color(0xFFFFFFFF),
                            size: 22.0,
                          )
                        ],
                      )),
                ),
              ),
            ),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30.0, top: 10.0),
                  child: Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.1, 0.5, 0.7, 0.9],
                            colors: [
                              /*Color(0xFF8C30F6),
                                      Color(0xFF8C30F6),
                                      Color(0xFF8C30F6),
                                      Color(0xFF8C30F6),*/
                              Color(0XFF34588F),
                              Color(0xFF386FB5),
                              Color(0XFF3CA3C3),
                              Color(0xFF49B1E3),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        ],
                      )),
                ),
              ),
            ),
          ],
        );
      }
    }

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(color: Colors.white),
          width: double.infinity,
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: "Hero",
                    child: Container(
                      height: height * .4,
                      child: Diagonal(
                        axis: Axis.horizontal,
                        clipHeight: height * .075,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.1, 0.5, 0.7, 0.9],
                              colors: [
                                /*Color(0xFF8C30F6),
                                      Color(0xFF8C30F6),
                                      Color(0xFF8C30F6),
                                      Color(0xFF8C30F6),*/
                                Color(0XFF34588F),
                                Color(0xFF386FB5),
                                Color(0XFF3CA3C3),
                                Color(0xFF49B1E3),
                              ],
                            ),
                          ),
                          child: Container(
                            width: width * .3,
                            child: Image(
                              image: AssetImage("assets/icons/tt_logo.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 0.0),
                    child: TextField(
                      decoration: new InputDecoration(labelText: 'Identifier'),
                      controller: usernameController,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 0.0),
                    child: TextField(
                      obscureText: true,
                      decoration: new InputDecoration(labelText: 'Password'),
                      controller: passwordController,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        errorMessage,
                        style: TextStyle(color: Colors.redAccent),
                      )
                    ],
                  ),
                  loginButton(),
                  //const
                  SizedBox(
                    height: 40.0,
                  ),

                  Container(
                    width: width,
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: width * .5 - 30,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "Register Now ",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: width * .04),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: width * .5 - 30,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "Forget your password ? ",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: width * .04),
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
          )),
    );
  }

  Future<void> getData() async {
    final SharedPreferences prefs = await _serial;
    print("we are here");
    String usr = usernameController.text;
    String psw = passwordController.text;

    String url =
        "https://ttappss.000webhostapp.com/login.php?token=5a773f9e8b9663b2918851ed6396feed63019b9a2f348cf69c9e96b3c0dbd960&phone=" +
            usr +
            "&password=" +
            psw;
    print(url);
    http.Response res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      var resBody = json.decode(res.body);
      String state = resBody["state"];
      print("state:" + state);
      if (state == "Success") {
        prefs.setString("fullName", resBody['userInfo']['fullName']);
        prefs.setString("phone", resBody['userInfo']['phone']);
        prefs.setString("id", resBody['userInfo']['id']);
        //prefs.setString("avatar", value)
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/home", (Route<dynamic> route) => false);
      } else {
        if (state == "loginError") {
          errorMessage = "Please check the informations provided";
          print("x");
        } else {
          errorMessage = "Connection error";
          print("faza2");
        }
        _state = 0;
      }
    });
  }
}
