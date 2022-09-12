import 'package:flutter/material.dart';
import 'package:pdfx_viewer/utils/constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  static var darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade700,
    colorScheme: const ColorScheme.dark(),
  );

  static var lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade100,
    colorScheme: const ColorScheme.light(),
  );

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyTheme {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade600,
    primaryColor: Constants.mainColor, //RGB: Color(0xFF343A40),
    appBarTheme: AppBarTheme(backgroundColor: Constants.accentColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Constants.accentColor,
        foregroundColor: Constants.txtColor),
    //colorScheme: const ColorScheme.dark(),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Constants.mainColor,
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade100,
    appBarTheme: AppBarTheme(backgroundColor: Constants.accentColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Constants.accentColor,
        foregroundColor: Constants.txtColor),
    //primarySwatch: Constants.myPrimaryColor,
    //colorScheme: const ColorScheme.light(),
    primaryColor: Constants.mainColor, //RGB: Color(0xFF343A40),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(primary: Constants.mainColor),
  );
}
