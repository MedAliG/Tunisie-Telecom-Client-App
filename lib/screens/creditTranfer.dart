import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:tt/objects/contact.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class TransfertCredit extends StatefulWidget {
  _TransfertCreditState createState() => new _TransfertCreditState();
}

class _TransfertCreditState extends State<TransfertCredit> {
  Iterable<Contact> contacts;
  List<ContactInfo> contactsInfo = new List<ContactInfo>();
  List<ContactInfo> stored = new List<ContactInfo>();
  int _state = 0;
  String selectedPhone = '';
  int selectedIndex = -1;
  TextEditingController amountController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  Future<SharedPreferences> _userInfo = SharedPreferences.getInstance();

  int _sendState = 0;
  /*SendState = 0  => nothing
    SendState = 1 => send success
    SendState = 2 => loading
    SendState = -1 => sendError
  */
  String _sendErrMsg = '';
  @override
  void initState() {
    _setPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Hero(
        tag: 'TranferHero',
        child: Material(
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                color: Color(0xFF8A3ADD),
                image: DecorationImage(
                    image: AssetImage(
                      'assets/wave-splash.png',
                    ),
                    fit: BoxFit.cover)),
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
      return _mainContent();
    }
  }

  _mainContent() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ListView(
      children: <Widget>[
        SizedBox(
          height: height * .03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Transfer de credit",
              style: TextStyle(
                  fontFamily: 'googleM',
                  fontSize: width * .06,
                  color: Colors.white),
            ),
          ],
        ),
        SizedBox(
          height: height * .03,
        ),
        Container(
          height: height * .15,
          width: width,
          margin: EdgeInsets.only(left: width * .125, right: width * .125),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.white, width: 2))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: height * .075,
                width: width * .45,
                padding: EdgeInsets.only(right: width * .008),
                child: TextField(
                  controller: amountController,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontFamily: 'googleB',
                      color: Colors.white,
                      fontSize: width * .1),
                  decoration: new InputDecoration.collapsed(
                      hintText: "500.0",
                      hintStyle: TextStyle(
                          fontFamily: 'googleB',
                          color: Colors.white,
                          fontSize: width * .1)),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                width: width * .2,
                height: height * .07,
                padding: EdgeInsets.only(bottom: height * .005),
                child: Text(
                  "Dinars",
                  style: TextStyle(
                    fontFamily: 'googleb',
                    fontSize: width * .045,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: height * .045,
        ),
        Container(
          width: width,
          padding: EdgeInsets.only(left: width * .09),
          child: Text(
            "Contact",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'google',
                fontSize: width * .04),
          ),
        ),
        SizedBox(
          height: height * .02,
        ),
        Container(
          width: width,
          padding: EdgeInsets.only(left: width * .11, right: width * .11),
          child: Column(
            children: <Widget>[
              Container(
                width: width * .78,
                height: height * .065,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(blurRadius: 3, color: Colors.black54)
                ], color: Colors.white, borderRadius: BorderRadius.circular(6)),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: height * .065,
                      padding: EdgeInsets.only(
                          top: height * .015,
                          left: width * .03,
                          right: width * .03,
                          bottom: height * .015),
                      child: Center(
                        child: Image(
                          image: AssetImage('assets/icons/user.png'),
                        ),
                      ),
                    ),
                    Container(
                      width: width * .6,
                      padding: EdgeInsets.only(left: width * .025),
                      child: Center(
                        child: TextField(
                          controller: contactController,
                          onChanged: (_) {
                            setState(() {
                              selectedIndex = -1;
                              _filter();
                              //to-do filtering
                            });
                          },
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black, fontSize: width * .05),
                          decoration: new InputDecoration.collapsed(
                              hintText: "+216 9xx xxx xxx",
                              hintStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: width * .05)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              Container(
                  width: width * .78,
                  height: height * .4,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(blurRadius: 3, color: Colors.black54)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)),
                  child: ListView.builder(
                    itemCount: contactsInfo.length,
                    itemBuilder: (BuildContext context, int index) {
                      ContactInfo c = contactsInfo[index];
                      return _contact(c, index);
                    },
                  )),
              SizedBox(
                height: height * .01,
              ),
              Container(
                height:
                    (_sendState == 1 || _sendState == -1) ? height * .03 : 0,
                child: Center(
                  child: Text(
                    _sendErrMsg,
                    style: TextStyle(
                        fontFamily: 'googleB',
                        fontSize: width * .045,
                        color: (_sendState == -1) ? Colors.redAccent : Colors.green),
                  ),
                ),
              ),
              Container(
                height: height * .1,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _sendContainer(height)
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _sendContainer(double height) {
    if (_sendState == 2) {
      return Center(
        child: CircularProgressIndicator(
          value: null,
          strokeWidth: 5.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return _sendBtn(height);
    }
  }

  _sendBtn(double height) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _sendState = 2;
        });
        _creditTransfer();
      },
      child: Container(
        height: height * .07,
        width: height * .07,
        padding: EdgeInsets.all(height * .02),
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)],
            shape: BoxShape.circle,
            color: Colors.white),
        child: Container(
          child: Center(
            child: Image(
                image: AssetImage('assets/icons/send.png'), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  _contact(ContactInfo c, int index) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPhone = c.phone;
          selectedIndex = index;
          contactController.text = c.phone;
        });
      },
      child: Container(
        padding: EdgeInsets.only(
            right: width * .03,
            left: width * .03,
            top: height * .005,
            bottom: height * .005),
        decoration: BoxDecoration(
          //border: Border(bottom: BorderSide(color: Colors.grey,width: 1))
          color:
              (index == selectedIndex) ? Color(0xFF8A3ADD) : Colors.transparent,
        ),
        height: height * .085,

        //margin: EdgeInsets.only(bottom: height * .005,top: height*.005),
        child: Row(
          children: <Widget>[
            Center(
              child: Container(
                width: width * .15,
                child: Container(
                  child: Center(
                      child: Text(
                    c.name[0],
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'GoogleB',
                        fontSize: width * .06),
                  )),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.lightBlue),
                  height: height * .07,
                  width: height * .07,
                ),
              ),
            ),
            Container(
              width: width * .02,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  //height: height * .11,
                  width: width * .55,
                  child: Center(
                    child: Text(
                      c.name,
                      style: TextStyle(
                          fontFamily: 'googleB',
                          fontSize: width * .05,
                          color: (selectedIndex == index)
                              ? Colors.white
                              : Colors.black87),
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      c.phone,
                      style: TextStyle(
                          fontFamily: 'googleM',
                          fontSize: width * .04,
                          color: (selectedIndex == index)
                              ? Colors.white54
                              : Colors.black45),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _setPermissions() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.contacts]);
    contacts = await ContactsService.getContacts();

    var it = contacts.iterator;
    print(contacts.length);
    while (it.moveNext()) {
      var it2 = it.current.phones.iterator;
      while (it2.moveNext()) {
        String number = it2.current.value;
        if (number.contains('+2169') || number.indexOf('9') == 0) {
          ContactInfo c = ContactInfo(it.current.displayName, number);
          contactsInfo.add(c);
          stored.add(c);
          setState(() {
            _state = 1;
          });
        }
      }
    }
  }

  _filter() {
    contactsInfo.clear();
    String input = contactController.text;
    for (int i = 0; i < stored.length; i++) {
      if (stored[i].phone.contains(input)) {
        setState(() {
          contactsInfo.add(stored[i]);
        });
      }
    }
  }

  _creditTransfer() async {
    final SharedPreferences prefs = await _userInfo;
    String userId = prefs.get("id");
    String receiver = contactController.text;
    String montant = amountController.text;
    receiver = receiver.replaceAll(' ', '');
    print(receiver);
    print(receiver.length);
    if (receiver.length != 8 && receiver.length != 12) {
      setState(() {
        _sendErrMsg = "Verifiez le numero inserer";
        _sendState = -1;
      });
      print("error");
    } else {
      if (receiver.length == 12) {
        receiver = receiver.replaceAll('+216', '');
      }
      String url =
          "https://ttappss.000webhostapp.com/insertTransfer.php?token=5a773f9e8b9663b2918851ed6396feed63019b9a2f348cf69c9e96b3c0dbd960&userId=" +
              userId +
              "&receiverPhone=" +
              receiver +
              "&montant=" +
              montant;
      print(url);
      http.Response res = await http
          .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
      var resBody = json.decode(res.body);
      print(resBody['state']);
      if (resBody['state'] == 'Successs') {
        setState(() {
          _sendState = 1;
          _sendErrMsg = "Envoit avec success";
        });
      } else if (resBody['state'] == "Sold insuffisant") {
        setState(() {
          _sendState = -1;
          _sendErrMsg = "Votre sold est insuffisant";
        });
      } else if (resBody['state'] == 'NoUserError') {
        setState(() {
          _sendState = -1;
          _sendErrMsg = "utilisateur non identifier";
        });
      } else {
        setState(() {
          _sendState = -1;
          _sendErrMsg = "Error non identifier";
        });
      }
    }
  }
}
