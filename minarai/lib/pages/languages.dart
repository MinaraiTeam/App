import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:minarai/enums/app_pages.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/other/appdata.dart';
import 'package:minarai/text/ui_text_manager.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context);

    return Scaffold(
      backgroundColor: Config.backgroundColor,
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LanguageButton(lang: 'es', data: appData),
          SizedBox(
            width: 16,
          ),
          LanguageButton(lang: 'jp', data: appData)
        ],
      )),
    );
  }
}

class LanguageButton extends StatelessWidget {
  final String lang;
  final AppData data;

  const LanguageButton({
    required this.lang,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12.0),
      elevation: 4.0,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () {
          if (!data.isCharging) {
            data.changeLanguage(lang);
            data.poblateArticleList();
            data.changeSubPage(AppSubPages.lobby);
          }
        },
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.blue,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/flag_$lang.png',
                width: 64.0,
                height: 64.0,
              ),
              SizedBox(height: 8.0),
              Text(
                UiTextManager.uiT.ui['languages_$lang'] ?? '',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'es'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
