import 'package:flutter/material.dart';
import 'package:minarai/other/app_pages.dart';
import 'package:minarai/other/appdata.dart';
import 'package:minarai/pages/article.dart';
import 'package:minarai/pages/category.dart';
import 'package:minarai/pages/configuration.dart';
import 'package:minarai/pages/home.dart';
import 'package:minarai/pages/languages.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AppData(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<AppData>(
        builder: (context, appData, child) => _buildPage(appData.currentPage),
      ),
    );
  }

  Widget _buildPage(AppPages currentPage) {
    switch (currentPage) {
      case AppPages.languages:
        return LanguagePage();
      case AppPages.home:
        return HomePage();
      case AppPages.category:
        return CategoryPage();
      case AppPages.article:
        return ArticlePage();
      case AppPages.configuration:
        return ConfigurationPage();
      default:
        return Center(child: Text("Error: Unknown Page"));
    }
  }
}
