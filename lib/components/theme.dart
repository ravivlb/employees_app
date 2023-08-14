import 'package:employees_app/utils/constants.dart';
import 'package:flutter/material.dart';

ThemeData primaryTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: kFontFamily,
    appBarTheme: appBarTheme(),
    primaryTextTheme:
        const TextTheme(titleSmall: TextStyle(color: kPrimaryColor)),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

/// AppBarTheme - colors, text styles
AppBarTheme appBarTheme() {
  return const AppBarTheme(
      color: kPrimaryColor,
      elevation: 0,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 18)
      );
}
