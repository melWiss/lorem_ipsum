import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lorem_ipsum/assets.dart';
import 'package:lorem_ipsum/fire.dart';
import 'package:lorem_ipsum/notifs.dart';
import 'package:lorem_ipsum/screens/emergency.dart';
import 'package:lorem_ipsum/screens/login.dart';
import 'package:lorem_ipsum/screens/navigation.dart';
import 'package:lorem_ipsum/screens/registration.dart';
import 'package:lorem_ipsum/streams/themeMode.dart';

import 'screens/carte.dart';
import 'screens/numbers.dart';
import 'widgets.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
    notify(message.notification.title, message.notification.body);
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  ThemeMode themeMode;
  @override
  void initState() {
    super.initState();
    themeMode = ThemeMode.dark;
    WidgetsBinding.instance.addObserver(this);
    final Brightness brightness =
        WidgetsBinding.instance.window.platformBrightness;
    setState(() {
      brightness == Brightness.dark
          ? themeMode = ThemeMode.dark
          : themeMode = ThemeMode.light;
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    final Brightness brightness =
        WidgetsBinding.instance.window.platformBrightness;
    setState(() {
      brightness == Brightness.dark
          ? themeMode = ThemeMode.dark
          : themeMode = ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureWidget(
      future: Firebase.initializeApp(),
      builder: (context, data) => MaterialApp(
        title: "Q'awini",
        themeMode: themeMode,
        theme: Assets.lighTheme,
        darkTheme: Assets.darkTheme,
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
