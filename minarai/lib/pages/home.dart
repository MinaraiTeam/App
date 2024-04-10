import 'package:flutter/material.dart';
import 'package:minarai/enums/assets.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/other/appdata.dart';
import 'package:minarai/other/article.dart';
import 'package:minarai/pages/subpages/lobby.dart';
import 'package:minarai/text/ui_text_manager.dart';
import 'package:minarai/widgets/appbar.dart';
import 'package:minarai/widgets/article_container.dart';
import 'package:minarai/widgets/category_container.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);

    return Scaffold(
        backgroundColor: Config.backgroundColor,
        appBar: MyAppBar(),
        body: data.subPage,
        bottomNavigationBar: NavigationBar(data: data));
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    super.key,
    required this.data,
  });

  final AppData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Config.borderColor)),
        color: Config.secondaryColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // First navigation item container
          GestureDetector(
            onTap: () =>
                data.changeCountry(0),
            child: Container(
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.height,
              color: data.selectedCountry == 0
                  ? Config.selectedColor
                  : Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/flag_es.png',
                      width: 40, height: 40),
                  Text(
                    UiTextManager.uiT.ui['country_es_${data.language}'],
                    style: TextStyle(
                      color: data.selectedCountry == 0 ? Config.fontText : Config.secondaryFontColor,
                      fontSize: data.selectedCountry == 0 ? Config.h4 : Config.hNormal
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Second navigation item container
          GestureDetector(
            onTap: () =>
                data.changeCountry(1),
            child: Container(
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.height,
              color: data.selectedCountry == 1
                  ? Config.selectedColor
                  : Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/flag_jp.png',
                      width: 40, height: 40),
                  Text(
                    UiTextManager.uiT.ui['country_jp_${data.language}'],
                    style: TextStyle(
                      color: data.selectedCountry == 1 ? Config.fontText : Config.secondaryFontColor,
                      fontSize: data.selectedCountry == 1 ? Config.h4 : Config.hNormal
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
