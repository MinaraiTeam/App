import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minarai/enums/theme_colors.dart';

class Config {
  //Icons
  static const double iconW = 32;
  static const double iconY = 32;

  //Fonts
  static const double h1 = 28;
  static const double h2 = h1 - 6;
  static const double h3 = h2 - 3;
  static const double h4 = h3 - 2;
  static const double hNormal = h4 - 3;
  static const double hMini = hNormal - 1;

  //Category Container
  static const double categoryContainerW = 180;
  static const double categoryContaineH = 170;

  //Article
  static const double MAX_WIDTH = 400;
  static const double MAX_HEIGHT = MAX_WIDTH - 50;

  //ColorTheme
  static Color backgroundColor = ThemeColors.wBackground;
  static Color secondaryColor = ThemeColors.wSecondary;
  static Color secondaryFontColor = ThemeColors.wSecFont;
  static Color fontText = ThemeColors.wFontText;
  static Color borderColor = ThemeColors.wBorder;
  static Color selectedColor = ThemeColors.wSelected;

  static Color errorColor = ThemeColors.wErrorBg;
  static Color errorFontColor = ThemeColors.wErrorFont;

  static Color buttonColor = ThemeColors.wButtonColor;

  //Global Context
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void applyTheme(Themes t) {
    switch (t) {
      case Themes.light:
        Config.backgroundColor = ThemeColors.wBackground;
        Config.secondaryColor = ThemeColors.wSecondary;
        Config.secondaryFontColor = ThemeColors.wSecFont;
        Config.fontText = ThemeColors.wFontText;
        Config.borderColor = ThemeColors.wBorder;
        Config.selectedColor = ThemeColors.wSelected;
        Config.buttonColor = ThemeColors.wButtonColor;
        Config.errorColor = ThemeColors.wErrorBg;
        Config.errorFontColor = ThemeColors.wErrorFont;
        break;

      case Themes.dark:
        Config.backgroundColor = ThemeColors.bBackground;
        Config.secondaryColor = ThemeColors.bSecondary;
        Config.secondaryFontColor = ThemeColors.bSecFont;
        Config.fontText = ThemeColors.bFontText;
        Config.borderColor = ThemeColors.bBorder;
        Config.selectedColor = ThemeColors.bSelected;
        Config.buttonColor = ThemeColors.bButtonColor;
        Config.errorColor = ThemeColors.bErrorBg;
        Config.errorFontColor = ThemeColors.bErrorFont;
        break;
      default:
    }
  }
}
