import 'package:flutter/material.dart';

enum Themes {
  light,
  dark,
  blue
}

class ThemeColors {
  //White Theme
  static const wBackground = Colors.white;
  static const wSecondary  = Color(0xFFF1EFF6);
  static const wFontText   = Colors.black;
  static const wBorder     = Color(0xFFBDBDBD);

  //Black Theme
  static const bBackground = Color(0xFF181818);
  static const bSecondary  = Color(0xFF1F1F1F);
  static const bFontText   = Colors.white;
  static const bBorder     = Color(0xFF121212);

  static const blBackground = Color(0xFF181818);
  static const blSecondary  = Color(0xFF1F1F1F);
  static const blFontText   = Colors.white;
  static const blBorder     = Color(0xFF121212);
}
