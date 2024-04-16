import 'package:flutter/material.dart';
import 'package:minarai/enums/assets.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/other/appdata.dart';
import 'package:minarai/other/article.dart';
import 'package:provider/provider.dart';

class ArticlePage extends StatefulWidget {
  final Article article;

  const ArticlePage({super.key, required this.article});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    final AppData data = Provider.of<AppData>(context, listen: false);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double contentWidth = screenWidth * 0.8;
    final double displayWidth =
        contentWidth < Config.MAX_WIDTH ? contentWidth : Config.MAX_WIDTH;

    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Container(
                  width: displayWidth,
                  child: AspectRatio(
                    aspectRatio: 2 / 1,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: data.urlServer+widget.article.preview_image,
                      fadeOutDuration: Duration(seconds: 1),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  height: 5,
                  width: displayWidth,
                  color: Assets.categoriesColors[widget.article.category_id],
                ),
                SizedBox(height: 20),
                Text(
                  widget.article.title,
                  style: TextStyle(
                      color: Config.fontText,
                      fontSize: Config.h2,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.article.date,
                  style: TextStyle(
                      color: Config.fontText, fontSize: Config.hNormal - 2),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // Since it's nested inside a SingleChildScrollView
                  itemCount: widget.article.content.length,
                  itemBuilder: (context, index) {
                    return Center(
                      // This will center the content horizontally
                      child: Container(
                        width: screenWidth,
                        child: data.checkIfImg(
                            widget.article.content[index], screenWidth),
                      ),
                    );
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
