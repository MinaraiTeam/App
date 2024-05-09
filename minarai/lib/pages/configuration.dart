import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:minarai/enums/app_pages.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/enums/theme_colors.dart';
import 'package:minarai/other/appdata.dart';
import 'package:minarai/text/ui_text_manager.dart';
import 'package:minarai/widgets/loading_popup.dart';
import 'package:provider/provider.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  late LiquidController lController;

  @override
  void initState() {
    super.initState();
    lController = LiquidController();
    // Ensuring the Widget is built before jumping to a page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppData data = Provider.of<AppData>(context, listen: false);
      int initialPage = ThemeColors.themeList
          .indexOf(ThemeColors.themeList[data.selectedTheme]);
      lController.jumpToPage(page: initialPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);

    return Scaffold(
      backgroundColor: Config.backgroundColor,
      appBar: AppBar(
        backgroundColor: Config.backgroundColor,
        leading: GestureDetector(
          child: Container(
              color: Colors.transparent, 
              child: Icon(Icons.arrow_back_ios, weight: Config.iconW, color: CupertinoColors.activeBlue,)),
          onTap: () { 
            data.changePage(AppPages.home);
            data.poblateArticleList();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(UiTextManager.uiT.ui['config_visual_${data.language}'], style: TextStyle(fontSize: Config.h2, fontWeight: FontWeight.bold, color: Config.fontText),),
                  SizedBox(height: 5,),
                  //Theme Picker
                  Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(width: 5, color: Config.borderColor),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: LiquidSwipe.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: ThemeColors.themeList[index].cBackground,
                            alignment: Alignment.center,
                            child: Text(
                              ThemeColors.themeList[index].themeName,
                              style: TextStyle(
                                  color: ThemeColors.themeList[index].cFontColor,
                                  fontSize: Config.h3,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                        itemCount: ThemeColors.themeList.length,
                        slideIconWidget: Icon(Icons.arrow_back_ios),
                        waveType: WaveType.liquidReveal,
                        enableSideReveal: true,
                        liquidController: lController,
                        preferDragFromRevealedArea: true,
                        ignoreUserGestureWhileAnimating: true,
                        onPageChangeCallback: (activePageIndex) {
                          data.changeTheme(
                              ThemeColors.themeList[activePageIndex].theme,
                              activePageIndex);
                        },
                      )),
                  SizedBox(height: 20,),
                  Text(UiTextManager.uiT.ui['config_others_${data.language}'], style: TextStyle(fontSize: Config.h2, fontWeight: FontWeight.bold, color: Config.fontText),),
                  SizedBox(height: 5,),
                  DownloadArticlesButton(),
                  SizedBox(height: 5,),
                  DeleteDataButton()
                ],
              ),
            ),
          ),
          ChargingPopup()
        ],
      ),
    );
  }
}


class DownloadArticlesButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Config.backgroundColor, backgroundColor: Config.fontText, // Text color
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded corners
        ),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        data.downloadArticles();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.download, color: Config.backgroundColor), // Download icon
          SizedBox(width: 10), // Space between icon and text
          Text(UiTextManager.uiT.ui['config_download_${data.language}']),
        ],
      ),
    );
  }
}

class DeleteDataButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Config.fontText, backgroundColor: Config.backgroundColor, // Text color
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded corners
          side: BorderSide(color: Config.fontText)
        ),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        data.deleteLocalFiles();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.delete, color: Config.fontText), // Download icon
          SizedBox(width: 10), // Space between icon and text
          Text(UiTextManager.uiT.ui['config_delete_${data.language}']),
        ],
      ),
    );
  }
}