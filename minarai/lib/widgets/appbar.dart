import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minarai/enums/app_pages.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/other/appdata.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context);

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      centerTitle: true,
      title: GestureDetector(
          child: Image.asset(
            appData.getFlagImg(appData.language),
            width: Config.iconW,
            height: Config.iconY,
          ),
          onTap: () => appData.changePage(AppPages.languages),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 8),
          child: IconButton(
            icon: Icon(
              Icons.settings,
              size: Config.iconW,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
