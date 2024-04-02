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
    data.poblateArticleList();

    return Scaffold(
      backgroundColor: Config.backgroundColor,
      appBar: MyAppBar(),
      body: data.subPage,
      bottomNavigationBar:  NavigationBar(data: data)
    );
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
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/flag_es.png', width: 64, height: 64,),
          label: UiTextManager.uiT.ui['country_es_${data.language}'],
          backgroundColor:Colors.amber 
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/flag_jp.png', width: 64, height: 64,),
          label: UiTextManager.uiT.ui['country_jp_${data.language}'],
          backgroundColor: data.selectedCountry == 1 ? Config.selectedColor : Colors.transparent
        )
      ],
      currentIndex: data.selectedCountry,
      onTap: data.changeCountry,
      backgroundColor: Config.secondaryColor,
    );
  }
}



