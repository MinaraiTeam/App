import 'package:flutter/material.dart';
import 'package:minarai/enums/app_pages.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/other/appdata.dart';
import 'package:minarai/pages/subpages/lobby.dart';
import 'package:minarai/text/ui_text_manager.dart';
import 'package:minarai/widgets/article_container.dart';
import 'package:minarai/widgets/filter_button.dart';
import 'package:minarai/widgets/loading_popup.dart';
import 'package:provider/provider.dart'; 

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);

    return Scaffold(
      backgroundColor: Config.backgroundColor,
      floatingActionButton: Align(
        
        alignment: Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(color: Config.backgroundColor.withOpacity(0.5),borderRadius: BorderRadius.all(Radius.circular(25))),
          margin: EdgeInsets.only(top: 22, left: 9),
          child: IconButton(
            onPressed: () {
              data.changeSubPage(Lobby(key: UniqueKey()));
            }, 
            icon: Icon(Icons.arrow_circle_left_outlined, color: Config.buttonColor, size: Config.iconW,)
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16),
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              child: TitleWidget(
                data: data,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: data.articleList.length == 0 ? Container(child: Text(UiTextManager.uiT.ui['error_notfound_${data.language}'], style: TextStyle(color: Config.secondaryFontColor),),) : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.articleList.length,
                    itemBuilder: (context, index) {
                      return ArticleContainer(article: data.articleList[index], previousPage: CategoryPage(),);
                    },
                  ),
                ),
              ),
            ),
            ChargingPopup()
          ],
        ),
      ),
    );
  }
}

//Widgets
///Title Text
class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.data});

  final AppData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: [
          
          Text(
            UiTextManager.uiT.ui['categories_${data.language}']
                [data.selectedCategory],
            style: TextStyle(
                fontSize: Config.h2,
                fontWeight: FontWeight.bold,
                color: Config.fontText),
          ),
          FilterButton()
        ],
      ),
    );
  }
}
