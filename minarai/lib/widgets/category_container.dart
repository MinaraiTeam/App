import 'package:flutter/material.dart';
import 'package:minarai/enums/app_pages.dart';
import 'package:minarai/enums/assets.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/other/appdata.dart';
import 'package:minarai/text/ui_text_manager.dart';

class categoryContainer extends StatelessWidget {
  const categoryContainer({
    super.key,
    required this.data,
    required this.index,
  });

  final AppData data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: Config.categoryContainerW,
        height: Config.categoryContaineH,
        margin: EdgeInsets.only(left: 6, right: 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Assets.categoriesColors[index],
              Assets.categoriesColors[index].withOpacity(0.7),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: OverflowBox(
            alignment: Alignment.topCenter,
            maxHeight: double.infinity,
            child: Column(
              children: [
                // Title of the Category
                Container(
                  height: Config.categoryContainerW * 0.2,
                  child: Center(
                    child: Text(
                      UiTextManager.uiT.ui['categories_${data.language}']
                          [index],
                      style: TextStyle(
                          fontSize: Config.h2,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                // Category photo
                Container(
                    height: Config.categoryContaineH * 0.79,
                    width: double.infinity,
                    child: ClipRRect(
                      child: Image.asset(
                        Assets.categoryImages[index],
                        fit: BoxFit.fill,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
      onTap: () => goToCatPage(),
    );
  }

  Future<void> goToCatPage() async {
    if (!data.isCharging) {
      data.isCharging = true;
      data.selectCategory(index);
      data.articleList.clear();

      if (data.connectMode) {
        data.articleList = await data.getArticlesHttp((index+1).toString(), "*", 2,
          data.language.toUpperCase(), data.countryName, "*", "ASC", "date");
      } else {
        data.articleList = await data.readFromLocalFile(data.articleFile, index.toString(), data.countryName, data.language.toUpperCase());
      }
    }
  }
}
