import 'package:flutter/material.dart';
import 'package:minarai/enums/app_pages.dart';
import 'package:minarai/enums/assets.dart';
import 'package:minarai/text/ui_text_manager.dart';

class AppData with ChangeNotifier {
  //Variable declaration
  AppPages currentPage = AppPages.languages;
  String language = 'es'; //[es, jp]
  String font = 'es'; //[es.ttf, jp.ttf]
  UiTextManager uiText = UiTextManager();

  //Functions
  ///Change App Language
  void changeLanguage(String lang) {
    this.language = lang;
    changePage(AppPages.home);
    changeFont(lang);
    notifyListeners();
  }

  ///Change the Font of the app
  void changeFont(String lang) {
    font = lang;
    notifyListeners();
  }

  ///Change Page
  void changePage(AppPages ap) {
    this.currentPage = ap;
    notifyListeners();
  }

  ///Get the flag Path
  String getFlagImg(String lang) {
    return 'assets/images/flag_$lang.png';
  }
}
