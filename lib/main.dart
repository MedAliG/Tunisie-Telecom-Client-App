import 'package:flutter/material.dart';
import 'package:tt/screens/SplashScreen.dart';
import 'package:tt/screens/login.dart';
import 'package:tt/screens/register.dart';
import 'package:tt/screens/home.dart';
import 'package:tt/screens/creditRecharge.dart';
import 'package:tt/screens/creditTranfer.dart';
import 'package:tt/screens/test.dart';
import 'package:tt/screens/forfait.dart';
import 'package:tt/screens/info.dart';
import 'package:tt/screens/historiqueForfait.dart';

void main() => runApp(new TTapps());

class TTapps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Navigation',
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new Login(),
        '/register': (BuildContext context) => new RegisterScreen(),
        '/home': (BuildContext context) => new HomeScreen(),
        '/creditRecharge': (BuildContext context) => new RechargeCredit(),
        '/creditTransfer': (BuildContext context) => new TransfertCredit(),
        '/forfait': (BuildContext context) => new ForfaitScreen(),
        '/info': (BuildContext context) => new Info(),
        '/histoForf': (BuildContext context) => new HistoriqueForfait(),
        '/test': (BuildContext context) => new MyApp()
      },
      home: new SplashScreen(),
    );
  }
}
