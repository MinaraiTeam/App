import 'dart:io';

import 'package:flutter/material.dart';
import 'package:minarai/enums/assets.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/other/appdata.dart';
import 'package:minarai/other/article.dart';
import 'package:minarai/pages/subpages/categorypage.dart';
import 'package:minarai/pages/subpages/lobby.dart';
import 'package:minarai/text/ui_text_manager.dart';
import 'package:minarai/widgets/loading_popup.dart';
import 'package:provider/provider.dart';

class ArticlePage extends StatefulWidget {
  final Article article;
  final Widget previousPage;

  const ArticlePage({super.key, required this.article, required this.previousPage});

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
      floatingActionButton: Align(
        alignment: Alignment.topLeft,
        child: Container(
          width: Config.iconW,
          height: Config.iconY,
          decoration: BoxDecoration(color: Config.backgroundColor.withOpacity(0.5),borderRadius: BorderRadius.all(Radius.circular(25))),
          margin: EdgeInsets.only(top: 22, left: 20),
          child: IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              data.changeSubPage(widget.previousPage);
            }, 
            icon: Icon(Icons.arrow_circle_left_outlined, color: Config.buttonColor, size: Config.iconW,)
          ),
        ),
      ),
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
                  maxWidth:  MediaQuery.of(context).size.width < 400 ? MediaQuery.of(context).size.width * 0.9 : 400, // Max width
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
                  ) : Image.file(File(widget.article.preview_image)),
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
                    Text('     ${UiTextManager.uiT.ui['art_author_${data.language}']}: ${widget.article.user_name}', style: TextStyle(color: Config.fontText, fontSize: Config.hMini),)
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
