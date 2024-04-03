
import 'package:flutter/material.dart';
import 'package:minarai/enums/assets.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/other/appdata.dart';
import 'package:minarai/other/article.dart';

class ArticleContainer extends StatelessWidget {
  const ArticleContainer({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 120,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Config.secondaryColor,
            border: Border(
                bottom: BorderSide(
                    width: 8,
                    color: Assets.categoriesColors[
                        article.category]))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.blue, // Color de ejemplo
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  'https://via.placeholder.com/${MediaQuery.of(context).size.width.round()}x${MediaQuery.of(context).size.height.round()}', 
                  fit: BoxFit.fitHeight, 
                  height: MediaQuery.of(context).size.height, 
                  width: 10, // Ancho deseado
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
                          fontSize: Config.h3,
                          fontWeight: FontWeight.bold,
                          color: Config.fontText),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      article.date,
                      style: TextStyle(
                        fontSize: Config.hNormal,
                        color: Config.secondaryFontColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ));
  }
}
