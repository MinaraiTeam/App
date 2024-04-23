import 'package:flutter/material.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/other/appdata.dart';
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

    return Container(
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
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data.articleList.length,
                  itemBuilder: (context, index) {
                    return ArticleContainer(article: data.articleList[index]);
                  },
                ),
              ),
            ),
          ),
          ChargingPopup()
        ],
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
