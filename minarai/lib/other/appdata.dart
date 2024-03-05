import 'package:flutter/material.dart';
import 'package:minarai/enums/app_pages.dart';
import 'package:minarai/enums/language_list.dart';
import 'package:minarai/text/ui_text_manager.dart';

class AppData with ChangeNotifier {

  //Variable declaration
  AppPages currentPage = AppPages.languages;
  Language language = Language.es;
  UiTextManager uiText = UiTextManager();
  
}
