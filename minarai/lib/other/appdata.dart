import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minarai/enums/app_pages.dart';
import 'package:minarai/enums/assets.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/enums/theme_colors.dart';
import 'package:minarai/other/article.dart';
import 'package:minarai/pages/subpages/categorypage.dart';
import 'package:minarai/pages/subpages/lobby.dart';
import 'package:minarai/text/ui_text_manager.dart';

class AppData with ChangeNotifier {
  AppPages currentPage = AppPages.languages;
  String language = 'es';
  String countryName = 'ES';
  String font = 'es';
  int selectedCategory = 0;
  int selectedCountry = 0;
  int selectedArticle = 0;
  Widget subPage = Lobby();
  bool isCharging = false;
  int selectedTheme = 0;

  final String urlServer = "https://minarai.ieti.site:443";
  final String urlGetList = "/api/article/list";
  final String urlCountView = "/api/article/sumview";
  UiTextManager uiText = UiTextManager();
  List<Article> latestArticles = [];
  List<Article> mostViewedArticles = [];
  List<Article> articleList = [];

  void forceNotifyListeners() {
    notifyListeners();
  }

  void changeLanguage(String lang) {
    language = lang;
    changePage(AppPages.home);
    changeFont(lang);
    notifyListeners();
  }

  void changeFont(String lang) {
    font = lang + '.ttf';
    notifyListeners();
  }

  void changePage(AppPages ap) {
    currentPage = ap;
    notifyListeners();
  }

  void changeSubPage(Widget sp) {
    subPage = sp;
    notifyListeners();
  }

  void changeTheme(Themes t, int themeId) {
    Config.applyTheme(t);
    selectedTheme = themeId;
    notifyListeners();
  }

  void changeCountry(int index) {
    selectedCountry = index;
    countryName = index == 0 ? "ES" : "JP";
    changeSubPage(Lobby(
      key: UniqueKey(),
    ));
    poblateArticleList();
    notifyListeners();
  }

  void selectCategory(int index) {
    selectedCategory = index;
    changeSubPage(CategoryPage(
      key: UniqueKey(),
    ));
    notifyListeners();
  }

  String getFlagImg(String lang) => 'assets/images/flag_$lang.png';

  Future<void> poblateArticleList() async {
    if (isCharging) return;
    latestArticles.clear();
    mostViewedArticles.clear();
    articleList.clear();

    isCharging = true;
    notifyListeners();
    latestArticles = await getArticlesHttp(
        "*", "*", 2, language.toUpperCase(), countryName, "*", "ASC", "date");
    mostViewedArticles = await getArticlesHttp(
        "*", "*", 2, language.toUpperCase(), countryName, "*", "ASC", "views");
    isCharging = false;
    notifyListeners();
  }

  Future<void> countView(int id) async {
    isCharging = true;
    notifyListeners();

    try {
      var response = await http.post(Uri.parse(urlServer + urlCountView),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"article_id": id}));
    } catch (e) {
      print(e);
    } finally {
      isCharging = false;
      notifyListeners();
    }
  }

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
      var response = await http.post(Uri.parse(urlServer + urlGetList),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'category': category,
            'user': user,
            'amount': amount,
            'language': language,
            'country': country,
            'date': date,
            'order': order,
            'orderBy': orderBy
          }));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data'];
        for (var a in data) {
          Article art = Article(
              article_id: a['article_id'],
              category_id: a['category_id'] - 1,
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
      } else {
        print(response.statusCode);
        throw Exception("Server Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      print(e);
      print("Exception in getArticlesHttp: $e");
    } finally {
      isCharging = false;
      notifyListeners();
    }
    return result;
  }

  Widget checkIfImg(String content, double screenWidth) {
    if (content.startsWith("/")) {
      return Center(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: 300, // Max height
            maxWidth: 300, // Max width
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), // Border radius
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image: urlServer + content,
              fit: BoxFit.cover,
              fadeInDuration: Duration(seconds: 1),
              fadeOutDuration: Duration(seconds: 1),
            ),
          ),
        ),
      );
    } else {
      return Center(
          child: Container(
              width: screenWidth * 0.8,
              child: Text(
                content,
                style: TextStyle(
                    fontSize: Config.hNormal, color: Config.secondaryFontColor),
              )));
    }
  }
}
