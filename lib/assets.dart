import 'package:flutter/material.dart';

class Assets {
  static Color primary = Colors.pink;
  static Color secondary = Colors.pink.shade100;
  static TextStyle title = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 42,
  );
  static TextStyle subTitle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  static ThemeData lighTheme = ThemeData(
    primarySwatch: Colors.pink,
    fontFamily: 'AkayaTelivigala',
    brightness: Brightness.light,
    accentColor: Colors.purple,
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.black54,
        size: 22,
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: "AkayaTelivigala",
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Assets.primary,
    ),
    iconTheme: IconThemeData(
      color: Colors.black54,
      size: 22,
    ),
    unselectedWidgetColor: Colors.black54,
    buttonColor: Colors.pink,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      headline5: TextStyle(
        color: Colors.black,
        fontSize: 24,
      ),
      headline4: TextStyle(
        color: Colors.black,
        fontSize: 34,
      ),
      headline3: TextStyle(
        color: Colors.black,
        fontSize: 48,
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontSize: 60,
      ),
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 96,
      ),
      subtitle1: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      subtitle2: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.pink,
    accentColor: Colors.purple,
    fontFamily: 'AkayaTelivigala',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 22,
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: "AkayaTelivigala",
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Assets.primary,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 22,
    ),
    unselectedWidgetColor: Colors.white,
    buttonColor: Colors.pink,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      headline5: TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
      headline4: TextStyle(
        color: Colors.white,
        fontSize: 34,
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontSize: 48,
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontSize: 60,
      ),
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 96,
      ),
      subtitle1: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      subtitle2: TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
    ),
  );
}
