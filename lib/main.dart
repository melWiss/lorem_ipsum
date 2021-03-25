import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lorem_ipsum/fire.dart';
import 'package:lorem_ipsum/screens/emergency.dart';
import 'package:lorem_ipsum/screens/login.dart';
import 'package:lorem_ipsum/screens/navigation.dart';
import 'package:lorem_ipsum/screens/registration.dart';

import 'screens/carte.dart';
import 'screens/numbers.dart';
import 'widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureWidget(
      future: Firebase.initializeApp(),
      builder: (context, data) => MaterialApp(
        title: "Q'awini",
        theme: ThemeData(
            primarySwatch: Colors.pink, fontFamily: 'AkayaTelivigala'),
        home: StreamWidget<User>(
          stream: qawini.auth.authStateChanges(),
          builder: (context, data) {
            return NavigationScreen();
          },
          onWait: (context) => Loginscreen(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Loginscreen();
  }
}
