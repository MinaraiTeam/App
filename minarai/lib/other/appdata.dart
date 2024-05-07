import 'dart:async';
import 'dart:convert';
import 'dart:io';
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
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

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
  bool connectMode = true;
  int selectedTheme = 0;

  final String urlServer = "https://minarai.ieti.site:443";
  final String urlGetList = "/api/article/list";
  final String urlCountView = "/api/article/sumview";
  final String urlGetUserName = "/api/user/name";
  UiTextManager uiText = UiTextManager();
  List<Article> latestArticles = [];
  List<Article> mostViewedArticles = [];
  List<Article> articleList = [];

  static String saveFolder = 'Minarai';
  String latestFile = 'latest.json';
  String mostViewFile = 'mostviewed.json';
  String articleFile = 'articles.json';

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
    if (!connectMode) {
      latestArticles =
          await readFromLocalFile(latestFile, '*', countryName, language);
      mostViewedArticles =
          await readFromLocalFile(mostViewFile, '*', countryName, language);
    } else {
      latestArticles = await getArticlesHttp("*", "*", 2,
          language.toUpperCase(), countryName, "*", "DESC", "date");

      if (latestArticles.isNotEmpty) {
        mostViewedArticles = await getArticlesHttp("*", "*", 2,
            language.toUpperCase(), countryName, "*", "DESC", "views");
      }
    }

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
          String userName = await getUserNameHttp(a['user_id']);
          Article art = Article(
              article_id: a['article_id'],
              category_id: a['category_id'] - 1,
              user_id: a['user_id'],
              user_name: userName,
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
      } else if (response.statusCode == 402) {
      } else {
        throw Exception("Server Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      showSnackBar('Connection Error');
      isCharging = false;
      notifyListeners();
      Future.delayed(Duration(milliseconds: 500))
          .then((value) => changePage(AppPages.languages));
      print("Exception in getArticlesHttp: $e");
      throw Exception("Error");
    } finally {
      isCharging = false;
      notifyListeners();
    }
    return result;
  }

  Future<String> getUserNameHttp(int user_id) async {
    isCharging = true;
    notifyListeners();

    String result = '';
    try {
      var response = await http.post(Uri.parse(urlServer + urlGetUserName),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'user_id': user_id,
          }));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        String status = jsonResponse['status'];
        String message = jsonResponse['message'];
        List<dynamic> data = jsonResponse['data'];
        Map<String, dynamic> firstUser = data.first;
        String name = firstUser['name'];

        result = name;
        return result;
      } else {
        throw Exception("Server Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      showSnackBar('Connection Error');
      isCharging = false;
      notifyListeners();
      Future.delayed(Duration(milliseconds: 700))
          .then((value) => changePage(AppPages.languages));
      print("Exception in getArticlesHttp: $e");
      return '';
    } finally {
      isCharging = false;
      notifyListeners();
    }
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
            child: connectMode
                ? FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    image: urlServer + content,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(seconds: 1),
                    fadeOutDuration: Duration(seconds: 1),
                  )
                : Container(),
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

  void showSnackBar(String msn) {
    ScaffoldMessenger.of(Config.navigatorKey.currentContext!)
        .showSnackBar(SnackBar(
            backgroundColor: Config.errorColor,
            content: Container(
              height: 40,
              child: Text(
                msn,
                style: TextStyle(
                    color: Config.errorFontColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Config.h3),
              ),
            )));
  }

  //Local Management
  Future<void> downloadArticles() async {
    isCharging = true;
    notifyListeners();

    List<Article> listArticles = [];
    listArticles = listArticles +
        await getArticlesHttp("*", "*", 2, "ES", "ES", "*", "DESC", "date");
    listArticles = listArticles +
        await getArticlesHttp("*", "*", 2, "ES", "JP", "*", "DESC", "date");
    listArticles = listArticles +
        await getArticlesHttp("*", "*", 2, "JP", "JP", "*", "DESC", "date");
    listArticles = listArticles +
        await getArticlesHttp("*", "*", 2, "JP", "ES", "*", "DESC", "date");
    if (listArticles != []) {
      await saveArticles(latestFile, listArticles);
    }

    listArticles.clear();
    listArticles = [];
    listArticles  = listArticles +
        await getArticlesHttp("*", "*", 2, "ES", "ES", "*", "DESC", "views");
    listArticles  = listArticles  +
        await getArticlesHttp("*", "*", 2, "ES", "JP", "*", "DESC", "views");
    listArticles  = listArticles  +
        await getArticlesHttp("*", "*", 2, "JP", "JP", "*", "DESC", "views");
    listArticles  = listArticles  +
        await getArticlesHttp("*", "*", 2, "JP", "ES", "*", "DESC", "views");
    if (listArticles != []) {
      await saveArticles(mostViewFile, listArticles);
    }

    List<Article> allList = [];
    allList = allList +
        await getArticlesHttp("*", "*", 20, "ES", "ES", "*", "DESC", "date");
    allList = allList +
        await getArticlesHttp("*", "*", 20, "ES", "JP", "*", "DESC", "date");
    allList = allList +
        await getArticlesHttp("*", "*", 20, "JP", "JP", "*", "DESC", "date");
    allList = allList +
        await getArticlesHttp("*", "*", 20, "JP", "ES", "*", "DESC", "date");

    if (allList != []) {
      await saveArticles(articleFile, allList);
    }

    isCharging = false;
    notifyListeners();
  }

  Future<void> saveArticles(String fileName, List<Article> data) async {
    isCharging = true;
    notifyListeners();

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String baseDir = appDocDir.path;
    String folderPath = path.join(baseDir, saveFolder);
    Directory directory = Directory(folderPath);

    final file = File('$folderPath/$fileName');

    try {
      // Check and create directory if it doesn't exist
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      // Ensure the file does not exist to write a fresh file
      if (await file.exists()) {
        await file.delete();
      }
      await file.create();

      // Resolve all asynchronous toJson calls
      List<Map<String, dynamic>> articlesJson =
          await Future.wait(data.map((article) => article.toJson()).toList());

      String jsonContent = jsonEncode(articlesJson);

      // Write the JSON string to the file
      await file.writeAsString(jsonContent);
    } catch (e) {
      print(e);
    } finally {
      isCharging = false;
      notifyListeners();
    }
  }

  Future<void> deleteLocalFiles() async {
    isCharging = true;
    notifyListeners();

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String baseDir = appDocDir.path;
    String folderPath =
        path.join(baseDir, saveFolder); // Asegúrate de definir 'saveFolder'

    final directory = Directory(folderPath);
    if (directory.existsSync()) {
      directory.listSync().forEach((file) {
        file.deleteSync();
      });
      print('Deleted');
    } else {
      print("Folder does not exist");
    }

    isCharging = false;
    notifyListeners();
  }

  Future<List<Article>> readFromLocalFile(
      String fileName, String category, String country, String lang) async {
    isCharging = true;
    notifyListeners();

    List<Article> result = [];
    try {
      // Get the directory for the application documents.
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String folderPath = path.join(appDocDir.path, saveFolder);

      // Ensure the folder exists
      Directory directory = Directory(folderPath);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      // Prepare the file path
      final filePath = path.join(folderPath, fileName);
      final file = File(filePath);

      // Check if the file exists before reading
      if (await file.exists()) {
        // Read the file
        String contents = await file.readAsString();

        // Decode the JSON data
        List<dynamic> jsonData = json.decode(contents);

        for (var a in jsonData) {
          List<dynamic> contentList = List<dynamic>.from(a['content']);

          if (category != '*' &&
              (a['category_id']) == int.parse(category) &&
              a['language'] == lang.toUpperCase() &&
              a['country'] == country) {
            Article art = Article(
                article_id: a['article_id'],
                category_id: a['category_id'],
                user_id: a['user_id'],
                user_name: a['user_name'],
                title: a['title'],
                preview_image: a['preview_image'],
                content: contentList,
                language: a['language'],
                annex: a['annex'],
                country: a['country'],
                date: a['date'],
                views: a['views'],
                url: urlServer);
            result.add(art);
          } else if (category == '*' &&
              a['language'] == lang.toUpperCase() &&
              a['country'] == country) {
            Article art = Article(
                article_id: a['article_id'],
                category_id: a['category_id'],
                user_id: a['user_id'],
                user_name: a['user_name'],
                title: a['title'],
                preview_image: a['preview_image'],
                content: contentList,
                language: a['language'],
                annex: a['annex'],
                country: a['country'],
                date: a['date'],
                views: a['views'],
                url: urlServer);
            result.add(art);
          }
        }
        return result;
      } else {
        print('File does not exist!');
        return result;
      }
    } catch (e) {
      print('An error occurred: $e');
      return result;
    } finally {
      isCharging = false;
      notifyListeners();
    }
  }

  static Future<String> downloadImage(String imageUrl) async {
    // Create the http client
    var client = http.Client();

    try {
      // Make the HTTP request to download the image
      var response = await client
          .get(Uri.parse("https://minarai.ieti.site:443" + imageUrl));
      if (response.statusCode == 200) {
        // Get the directory to save the image
        var directory = await getApplicationDocumentsDirectory();
        var imagePath =
            path.join(directory.path, saveFolder, path.basename(imageUrl));

        // Create the folder if it doesn't exist
        await Directory(path.dirname(imagePath)).create(recursive: true);

        // Write the image to a file
        var file = File(imagePath);
        await file.writeAsBytes(response.bodyBytes);
        // Return the path of the downloaded image
        return imagePath;
      } else {
        throw Exception(
            'Failed to download image: Status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to download image: $e');
    } finally {
      // Close the client to prevent memory leak
      client.close();
    }
  }
}
