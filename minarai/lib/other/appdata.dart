import 'package:flutter/material.dart';
import 'package:minarai/enums/app_pages.dart';
import 'package:minarai/enums/assets.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/enums/theme_colors.dart';
import 'package:minarai/other/article.dart';
import 'package:minarai/pages/subpages/categorypage.dart';
import 'package:minarai/pages/subpages/lobby.dart';
import 'package:minarai/text/ui_text_manager.dart';

class AppData with ChangeNotifier {
  //Variable declaration
  ///Selectables
  AppPages currentPage = AppPages.languages;
  String language = 'es'; //[es, jp]
  String font = 'es'; //[es.ttf, jp.ttf]
  int selectedCategory = 0;
  int selectedCountry = 0; //[spain, japan]
  Widget subPage = Lobby();

  ///No selectables
  UiTextManager uiText = UiTextManager();
  List<Article> latestArticles = [];
  List<Article> mostViewedArticles = [];
  List<Article> articleList = [];

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

  ///change SubPage
  void changeSubPage(AppSubPages sp) {
    switch (sp) {
      case AppSubPages.lobby:
        subPage = Lobby();
        break;
      case AppSubPages.categorypage:
        subPage = CategoryPage();
        break;
      default:
        subPage = Lobby();
    }
  }

  ///Change app Theme
  void changeTheme(Themes t) {
    switch (t) {
      case Themes.light:
        Config.backgroundColor = ThemeColors.wBackground;
        Config.secondaryColor = ThemeColors.wSecondary;
        Config.secondaryFontColor = ThemeColors.wSecFont;
        Config.fontText = ThemeColors.wFontText;
        Config.borderColor = ThemeColors.wBorder;
        Config.selectedColor = ThemeColors.wSelected;
        break;

      case Themes.dark:
        Config.backgroundColor = ThemeColors.bBackground;
        Config.secondaryColor = ThemeColors.bSecondary;
        Config.secondaryFontColor = ThemeColors.bSecFont;
        Config.fontText = ThemeColors.bFontText;
        Config.borderColor = ThemeColors.bBorder;
        Config.selectedColor = ThemeColors.bSelected;
        break;
      default:
    }
  }

  ///Change Country
  void changeCountry(int index) {
    selectedCountry = index;
    changeSubPage(AppSubPages.lobby);
    notifyListeners();
  }

  ///Select Category
  void selectCategory(int index) {
    selectedCategory = index;
    changeSubPage(AppSubPages.categorypage);
    notifyListeners();
  }

  ///Get the flag Path
  String getFlagImg(String lang) {
    return 'assets/images/flag_$lang.png';
  }

  ///Poblate article list
  void poblateArticleList() {
    if (latestArticles.length < 10) {
      for (int i = 0; i < 10; i++) {
        final art = Article(
            article_id: 0,
            category: 0,
            user_id: 1,
            title:
                "Festival de las Muñecas ----------------------------------------------------",
            preview_image: '',
            content: 'hh',
            language: Country.es,
            annex: '',
            country: Country.jp,
            date: '10/10/2010',
            views: 8);

        latestArticles.add(art);
        articleList.add(art);
        mostViewedArticles.add(art);
      }
    }
  }
}
