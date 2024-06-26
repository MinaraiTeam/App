import 'dart:io';

import 'package:flutter/material.dart';
import 'package:minarai/enums/app_pages.dart';
import 'package:minarai/enums/assets.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/other/appdata.dart';
import 'package:minarai/other/article.dart';
import 'package:minarai/pages/article_page.dart';
import 'package:minarai/text/ui_text_manager.dart';
import 'package:provider/provider.dart';

class ArticleContainer extends StatelessWidget {
  const ArticleContainer({super.key, required this.article, required this.previousPage});

  final Article article;
  final Widget previousPage;

  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context, listen: false);

    return GestureDetector(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 120,
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Config.secondaryColor,
              border: Border(
                  bottom: BorderSide(
                      width: 8,
                      color: Assets.categoriesColors[article.category_id] ??
                          Colors.grey))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // Border radius
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: data.connectMode ? FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    image: data.urlServer + article.preview_image,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(seconds: 1),
                    fadeOutDuration: Duration(seconds: 1),
                  ) : Image.file(
                    File(article.preview_image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      article.title,
                      style: TextStyle(
                          fontSize: Config.h4,
                          fontWeight: FontWeight.bold,
                          color: Config.fontText),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      article.date,
                      style: TextStyle(
                        fontSize: Config.hNormal - 2,
                        color: Config.secondaryFontColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
      onTap: () {
        data.selectedArticle = data.articleList.indexOf(article);
        data.changeSubPage(ArticlePage(key: UniqueKey(), article: article, previousPage: previousPage,));

        if(data.connectMode) {
          data.countView(article.article_id);
        }
        
        data.forceNotifyListeners();
      },
    );
  }
}
