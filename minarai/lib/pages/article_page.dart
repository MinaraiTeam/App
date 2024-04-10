import 'package:flutter/material.dart';
import 'package:minarai/enums/assets.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/other/appdata.dart';
import 'package:minarai/other/article.dart';
import 'package:provider/provider.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context, listen: false);
    final Article article = data.articleList[data.selectedArticle];

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              article.preview_image,
              width: MediaQuery.of(context).size.width / 0.8 < Config.MAX_WIDH
                  ? MediaQuery.of(context).size.width / 0.8
                  : Config.MAX_WIDH,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 10,
              width: MediaQuery.of(context).size.width / 0.8 < Config.MAX_WIDH
                  ? MediaQuery.of(context).size.width / 0.8
                  : Config.MAX_WIDH,
              color: Assets.categoriesColors[article.category_id],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: ListView.builder(
                itemCount: article.content.length,
                itemBuilder: (context, index) {
                  Widget content = data.checkIfImg(article.content[index],
                      MediaQuery.of(context).size.width);

                  return content; 
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
