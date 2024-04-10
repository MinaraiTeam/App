import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minarai/enums/app_pages.dart';
import 'package:minarai/enums/assets.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
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
  String countryName = 'ES';
  String font = 'es'; //[es.ttf, jp.ttf]
  int selectedCategory = 0;
  int selectedCountry = 0; //[spain, japan]
  int selectedArticle = 0;
  Widget subPage = Lobby();
  bool isCharging = false;

  ///No selectables
  String urlServer = "https://minarai.ieti.site:443/";
  String urlGetList = "/api/article/list";
  UiTextManager uiText = UiTextManager();
  List<Article> latestArticles = [];
  List<Article> mostViewedArticles = [];
  List<Article> articleList = [];

  //Functions
  void forceNotifyListeners() {
    notifyListeners();
  }

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
    notifyListeners();
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
    notifyListeners();
  }

  ///Change Country
  void changeCountry(int index) {
    selectedCountry = index;
    countryName = selectedCountry == 0 ? "ES" : "JP";
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
  // Assuming this is inside a class that extends ChangeNotifier
  Future<void> poblateArticleList() async {
    latestArticles = await getArticlesHttp(
        "*", "*", 2, language.toUpperCase(), countryName, "*", "ASC", "date");
    mostViewedArticles = await getArticlesHttp(
        "*", "*", 2, language.toUpperCase(), countryName, "*", "ASC", "views");
    notifyListeners();
  }

  //Messages to the server
  Future<List<Article>> getArticlesHttp(
      String category,
      String user,
      int amount,
      String language,
      String country,
      String date,
      String order,
      String orderBy) async {
    isCharging = true;
    notifyListeners();
    List<Article> result = [];

    try {
      var response = await http.post(
        Uri.parse(urlServer + urlGetList),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'category': category,
          'user': user,
          'amount': amount,
          'language': language,
          'country': country,
          'date': date,
          'order': order,
          'orderBy': orderBy
        }),
      );

      if (response.statusCode == 200) {
        try {
          var json = jsonDecode(response.body);
          print(json);
          List<dynamic> data = json['data'];

          for (var a in data) {
            Article art = Article(
                article_id: a['article_id']-1,
                category_id: a['category_id'],
                user_id: a['user_id'],
                title: a['title'],
                preview_image: a['preview_image'],
                content: jsonDecode(a['content'])['content'],
                language: a['language'],
                annex: a['annex'],
                country: a['country'],
                date: a['date'],
                views: a['views'],
                url: urlServer);
            result.add(art);
          }
          return result;
        } catch (e) {
          print(
              "Error --------------------------------\n$e\n-------------------------------------");
          return result;
        }
      } else {
        print(response.statusCode);
        return result;
        throw "Error del servidor (appData/loadHttpPostByChunks): ${response.reasonPhrase}";
      }
    } catch (e) {
      return result;
      throw "Excepción (appData/loadHttpPostByChunks): $e";
    } finally {
      isCharging = false;
      notifyListeners();
    }
  }

  //
  Widget checkIfImg(String content, double screenWidth) {
    if (content.startsWith("/")) {
      return Image.network(
        urlServer + content,
        width: screenWidth / 0.8 < Config.MAX_WIDH
            ? screenWidth / 0.8
            : Config.MAX_WIDH,
      );
    } else {
      return Container(
        width: screenWidth / 0.8 < Config.MAX_WIDH
            ? screenWidth / 0.8
            : Config.MAX_WIDH,
        child: Text(content),
      );
    }
  }
}
