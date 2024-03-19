import 'package:flutter/material.dart';
import 'package:minarai/enums/assets.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/other/appdata.dart';
import 'package:minarai/text/ui_text_manager.dart';
import 'package:minarai/widgets/appbar.dart';
import 'package:minarai/widgets/categoryContainer.dart';
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
      body: Container(
        padding: EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              UiTextManager.uiT.ui['category_${data.language}'],
              style:
                  TextStyle(fontSize: Config.h1, fontWeight: FontWeight.bold, color: Config.fontText),
            ),
            const SizedBox(
              height: 8,
            ),

            //Category Widgets
            Container(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: UiTextManager
                      .uiT.ui['categories_${data.language}'].length,
                  itemBuilder: (context, index) {
                    //CategoryBox
                    return categoryContainer(data: data, index: index,);
                  },
                )),
            const SizedBox(
              height: 24,
            ),
            Text(
              UiTextManager.uiT.ui['latest_${data.language}'],
              style:
                  TextStyle(fontSize: Config.h1, fontWeight: FontWeight.bold, color: Config.fontText),
            ),
            const SizedBox(
              height: 8,
            ),

            //Latest Articles
            Container(
              height: 500,
              child: ListView.builder(
                itemCount: data.latestArticles.length,
                itemBuilder:(context, index) {
                
              },),
            )
          ],
        ),
      ),
    );
  }
}


