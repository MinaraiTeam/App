import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:minarai/enums/app_pages.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/enums/theme_colors.dart';
import 'package:minarai/other/appdata.dart';
import 'package:provider/provider.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);

    return Scaffold(
      backgroundColor: Config.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    data.changePage(AppPages.home);
                  },
                  child: Text("Back")),
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 100,
                  child: LiquidSwipe.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: ThemeColors.themeList[index].cBackground,
                        child: Text(
                          ThemeColors.themeList[index].themeName,
                          style: TextStyle(
                              color: ThemeColors.themeList[index].cFontColor),
                        ),
                      );
                    },
                    itemCount: ThemeColors.themeList.length,
                    slideIconWidget: Icon(Icons.arrow_back_ios),
                    ignoreUserGestureWhileAnimating: true,
                    onPageChangeCallback: (activePageIndex) {
                      data.changeTheme(
                          ThemeColors.themeList[activePageIndex].theme);
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
