import 'package:flutter/material.dart';
import 'package:minarai/enums/assets.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/other/appdata.dart';
import 'package:minarai/other/article.dart';
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24,),
              Title(section: "category", language: data.language,),
              const SizedBox(height: 8,),

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
              Title(section: "latest", language: data.language,),
              const SizedBox(height: 8,),
              SectionContainer(infoList: data.latestArticles),

              //Most Viewed
              const SizedBox(height: 24,),
              Title(section: "mostviewed", language: data.language,),
              SectionContainer(infoList: data.mostViewedArticles),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
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
  });

  final List<Article> infoList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: infoList.length > 2
            ? 2
            : infoList.length,
        itemBuilder: (context, index) {
          //Article Container
          return ArticleContainer(
            article: infoList[index],
            index: index,
          );
        },
      ),
    );
  }
}
