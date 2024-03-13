import 'package:flutter/material.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/other/appdata.dart';
import 'package:minarai/text/ui_text_manager.dart';
import 'package:minarai/widgets/appbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);

    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        padding: EdgeInsets.only(left: 16),
        child: Column(
          children: [
            SizedBox(height: 24,),
            Text(
              UiTextManager.uiT.ui['category_${data.language}'] ?? '',
              style: TextStyle(
                fontSize: Config.h1,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}
