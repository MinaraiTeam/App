import 'package:flutter/material.dart';

enum Themes { light, dark, blue }

class ThemeColors {
  //White Theme
  static const wBackground = Colors.white;
  static const wSecondary = Color(0xFFF1EFF6);
  static const wFontText = Colors.black;
  static const wSecFont = Color.fromARGB(255, 56, 56, 56);
  static const wBorder = Color(0xFFBDBDBD);
  static const wSelected = Color.fromARGB(255, 56, 56, 56);

  //Black Theme
  static const bBackground = Color(0xFF181818);
  static const bSecondary = Color(0xFF1F1F1F);
  static const bFontText = Colors.white;
  static const bSecFont = Color.fromARGB(255, 177, 177, 177);
  static const bBorder = Color(0xFF121212);
  static const bSelected = Color.fromARGB(255, 177, 177, 177);
}
