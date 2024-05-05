import 'package:flutter/material.dart';
import 'package:minarai/enums/assets.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/other/appdata.dart';
import 'package:minarai/other/article.dart';
import 'package:minarai/widgets/loading_popup.dart';
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
      backgroundColor: Config.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Container(
                constraints: BoxConstraints(
                  maxHeight: 300, // Max height
                  maxWidth: 400, // Max width
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // Border radius
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: data.connectMode ? FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    image: data.urlServer + widget.article.preview_image,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(seconds: 1),
                    fadeOutDuration: Duration(seconds: 1),
                  ) : Image.asset(widget.article.preview_image),
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: 5,
                width: displayWidth,
                color: Assets.categoriesColors[widget.article.category_id],
              ),
              SizedBox(height: 15),
              Container(
                constraints: BoxConstraints(maxWidth: screenWidth * 0.9),
                child: Text(
                  widget.article.title,
                  style: TextStyle(
                      color: Config.fontText,
                      fontSize: Config.h1,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.article.date,
                      style: TextStyle(
                          color: Config.fontText, fontSize: Config.hMini),
                    ),
                    SizedBox(width: 10,),
                    Text('👁️${widget.article.views}', style: TextStyle(color: Config.fontText, fontSize: Config.hMini),),
                    Text('     user:${widget.article.user_name}', style: TextStyle(color: Config.fontText, fontSize: Config.hMini),)
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.article.content.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 1130
                      ),
                      margin: EdgeInsets.only(top: 8, bottom: 8),
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
    );
  }
}
