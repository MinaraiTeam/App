import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Themes { light, dark, blue }

class ThemeColors {
  static List<AppTheme> themeList = [
    AppTheme("Light", Themes.light, wBackground, wFontText),
    AppTheme("Black", Themes.dark, bBackground, bFontText)
  ];
  //White Theme
  static const wBackground = Colors.white;
  static const wSecondary = Color(0xFFF1EFF6);
  static const wFontText = Colors.black;
  static const wSecFont = Color.fromARGB(255, 56, 56, 56);
  static const wBorder = Color(0xFFBDBDBD);
  static const wSelected = Color.fromARGB(255, 199, 199, 199);
  static const wButtonColor = CupertinoColors.activeBlue;
  static const wErrorBg = CupertinoColors.destructiveRed;
  static const wErrorFont = CupertinoColors.white;

  //Black Theme
  static const bBackground = Color(0xFF181818);
  static const bSecondary = Color(0xFF1F1F1F);
  static const bFontText = Colors.white;
  static const bSecFont = Color.fromARGB(255, 177, 177, 177);
  static const bBorder = Color(0xFF121212);
  static const bSelected = Color.fromARGB(255, 51, 51, 51);
  static const bButtonColor = CupertinoColors.activeBlue;
  static const bErrorBg = CupertinoColors.destructiveRed;
  static const bErrorFont = CupertinoColors.white;
}

class AppTheme {
  late String themeName;
  late Color cBackground;
  late Color cFontColor;
  late Themes theme;

  AppTheme(String name, Themes theme, Color cB, Color cF) {
    this.themeName = name;
    this.theme = theme;
    this.cBackground = cB;
    this.cFontColor = cF;
  }
}
