import 'package:flutter/material.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  _RegisterScreenState createState() => new _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Future<SharedPreferences> _serial = SharedPreferences.getInstance();

  TextEditingController nameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController pass2Controller = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  int _state = 0;
  String errorMessage = "";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: ListView(
          children: <Widget>[
            Hero(
              tag: "Hero",
              child: Container(
                height: height * .4,
                child: Diagonal(
                  position: DiagonalPosition.BOTTOM_RIGHT,
                  axis: Axis.horizontal,
                  clipHeight: height * .075,
                  child: Container(
                    child: Container(
                      width: width * .3,
                      child: Image(
                        image: AssetImage("assets/icons/tt_logo.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.1, 0.5, 0.7, 0.9],
                        colors: [
                          Color(0XFF34588F),
                          Color(0xFF386FB5),
                          Color(0XFF3CA3C3),
                          Color(0xFF49B1E3),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: width * .1, right: width * .1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: new InputDecoration(labelText: 'Full name'),
                    controller: nameController,
                  ),
                  TextField(
                      decoration:
                          new InputDecoration(labelText: 'Phone number'),
                      controller: phoneController,
                      keyboardType: TextInputType.phone),
                  TextField(
                    decoration: new InputDecoration(labelText: 'Password'),
                    controller: passController,
                    obscureText: true,
                  ),
                  TextField(
                    decoration: new InputDecoration(labelText: 'Re-Password'),
                    controller: pass2Controller,
                    obscureText: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _state = 10;
                      });
                      _registerUser();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: height * .05),
                      padding: EdgeInsets.only(
                          top: 15,
                          bottom: 15,
                          left: width * .05,
                          right: width * .05),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.1, 0.5, 0.7, 0.9],
                            colors: [
                              Color(0XFF34588F),
                              Color(0xFF386FB5),
                              Color(0XFF3CA3C3),
                              Color(0xFF49B1E3),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30)),
                      child: (_state != 10)
                          ? Center(
                              child: Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.white, fontSize: width * .04),
                            ))
                          : CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _registerUser() async {
    final SharedPreferences prefs = await _serial;

    String name = nameController.text;

    String pass = passController.text;
    String pass2 = pass2Controller.text;
    String phone = phoneController.text;
    if ((name.isEmpty) | (phone.isEmpty)) {
      setState(() {
        _state = -1;
        errorMessage = "Please fill in all the fields !";
      });
    }
    if (pass != pass2) {
      setState(() {
        print("not equal");
        _state = -1;
        errorMessage = "Passwords doesn't match !";
      });
    } else {
      if (pass.length < 6) {
        setState(() {
          errorMessage = "Password must have at least 6 characters !";
          _state = -1;
        });
      } else {
        String url =
            "https://ttappss.000webhostapp.com/register.php?token=5a773f9e8b9663b2918851ed6396feed63019b9a2f348cf69c9e96b3c0dbd960&fullName=" +
                name +
                "&phone=" +
                phone +
                "&password=" +
                pass;
        print(url);
        http.Response res = await http
            .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
        var resBody = jsonDecode(res.body);
        if (resBody["state"] == "Success") {
          String url1 =
              "https://ttappss.000webhostapp.com/insertTransfert.php?token=5a773f9e8b9663b2918851ed6396feed63019b9a2f348cf69c9e96b3c0dbd960&phone=" +
                  phone;
          http.Response res1 = await http.get(Uri.encodeFull(url1),
              headers: {"Accept": "application/json"});
          var resBody1 = jsonDecode(res1.body);
          setState(() {
            _state = 1;
            prefs.setString("id", resBody1['userInfo']['id']);
            prefs.setString("fullName", name);
            prefs.setString("phone", phone);
            Navigator.of(context).pushNamedAndRemoveUntil(
                "/home", (Route<dynamic> route) => false);
          });
        } else {
          _state = -1;
        }
      }
    }
  }
}
