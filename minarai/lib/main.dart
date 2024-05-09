import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minarai/enums/app_pages.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/enums/theme_colors.dart';
import 'package:minarai/other/appdata.dart';
import 'package:minarai/pages/article_page.dart';
import 'package:minarai/pages/configuration.dart';
import 'package:minarai/pages/home.dart';
import 'package:minarai/pages/languages.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  //If its on mobile it will show the SplashScreen
  if (Platform.isIOS || Platform.isAndroid) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    // sleep(const Duration(seconds: 1));
    // FlutterNativeSplash.remove();
  } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    //WindowManager.instance.setMinimumSize(const Size(1200, 600));
  }

  runApp(ChangeNotifierProvider(
    create: (context) => AppData(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Set The AppColorTheme
    final AppData data = Provider.of<AppData>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<AppData>(
        builder: (context, appData, child) => _buildPage(appData.currentPage),
      ),
      navigatorKey: Config.navigatorKey,
    );
  }

  Widget _buildPage(AppPages currentPage) {
    switch (currentPage) {
      case AppPages.languages:
        return LanguagePage();
      case AppPages.home:
        return HomePage();
      case AppPages.configuration:
        return ConfigurationPage();
      default:
        return Center(child: Text("Error: Unknown Page"));
    }
  }
}
