import 'package:flutter/material.dart';

class CustomTheme {
  static final lightTheme = ThemeData(
    //background color
    scaffoldBackgroundColor: Colors.white,
    //primary text color
    primaryColor: const Color(0xff002055),
    //secondary icon/text color
    iconTheme: const IconThemeData(color: Color(0xff756EF3)),
  );
  static final darkTheme = ThemeData(
      //background color
      scaffoldBackgroundColor: const Color(0xff0A0C16),
      //primary text color
      primaryColor: const Color(0xffFFFFFF),
      //secondary icon/text color
      iconTheme: const IconThemeData(color: Color(0xff3580FF)),
      elevatedButtonTheme: const ElevatedButtonThemeData());
}
