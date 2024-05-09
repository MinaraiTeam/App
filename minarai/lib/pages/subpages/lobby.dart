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
import 'package:minarai/widgets/loading_popup.dart';
import 'package:provider/provider.dart';

class Lobby extends StatelessWidget {
  const Lobby({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);
    
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Title(
              section: "category",
              language: data.language,
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
                    return categoryContainer(
                      data: data,
                      index: index,
                    );
                  },
                )),
            const SizedBox(
              height: 24,
            ),

            //Latest Articles
            Title(
              section: "latest",
              language: data.language,
            ),
            const SizedBox(
              height: 8,
            ),
            SectionContainer(infoList: data.latestArticles, language: data.language,),

            //Most Viewed
            const SizedBox(
              height: 24,
            ),
            Title(
              section: "mostviewed",
              language: data.language,
            ),
            SectionContainer(infoList: data.mostViewedArticles, language: data.language,),
            const SizedBox(
              height: 24,
            ),
            
          ],
        ),
      ),
    );
  }
}

//Widgets
///Title Text
class Title extends StatelessWidget {
  const Title({super.key, required this.language, required this.section});

  final String section;
  final String language;

  @override
  Widget build(BuildContext context) {
    return Text(
      UiTextManager.uiT.ui['${section}_${language}'],
      style: TextStyle(
          fontSize: Config.h1,
          fontWeight: FontWeight.bold,
          color: Config.fontText),
    );
  }
}

///Container for the sections
class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.infoList,
    required this.language
  });

  final List<Article> infoList;
  final String language;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: infoList.length == 0 ? 100 : 300,
      child: infoList.length == 0 ? Container(child: Text(UiTextManager.uiT.ui['error_notfound_$language'], style: TextStyle(color: Config.secondaryFontColor),),) : ListView.builder(
        itemCount: infoList.length >= 2 ? 2 : infoList.length,
        itemBuilder: (context, index) {
          //Article Container
          return ArticleContainer(
            article: infoList[index],
            previousPage: Lobby(),
          );
        },
      ),
    );
  }
}
