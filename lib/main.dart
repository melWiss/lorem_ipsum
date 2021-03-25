import 'package:flutter/material.dart';
import 'package:lorem_ipsum/emergency.dart';
import 'package:lorem_ipsum/login.dart';
import 'package:lorem_ipsum/navigation.dart';
import 'package:lorem_ipsum/registration.dart';

import 'carte.dart';
import 'numbers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Q'awini",
      theme:
          ThemeData(primarySwatch: Colors.pink, fontFamily: 'AkayaTelivigala'),
      home: Numberscreen(),
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
