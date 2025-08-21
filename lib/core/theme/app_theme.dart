import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.green,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
  );


  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.brown,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
}