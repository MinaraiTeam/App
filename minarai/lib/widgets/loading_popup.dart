import 'package:flutter/material.dart';
import 'package:minarai/enums/config.dart';
import 'package:minarai/other/appdata.dart';
import 'package:minarai/text/ui_text_manager.dart';
import 'package:provider/provider.dart';

class ChargingPopup extends StatefulWidget {
  @override
  _ChargingPopupState createState() => _ChargingPopupState();
}

class _ChargingPopupState extends State<ChargingPopup> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAndDisplayDialog();
    });
  }

  void checkAndDisplayDialog() {
    var appData = Provider.of<AppData>(context, listen: false);
    if (appData.isCharging) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Config.backgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10,),
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(UiTextManager.uiT.ui['loading_${appData.language}'], style: TextStyle(color: Config.fontText, fontWeight: FontWeight.bold),),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<AppData, bool>(
      selector: (_, appData) => appData.isCharging,
      builder: (_, isCharging, __) {
        if (!isCharging) {
          // Only try to pop if there's a dialog shown.
          if (ModalRoute.of(context)?.isCurrent == false) {
            Navigator.of(context, rootNavigator: true).pop();
          }
        }
        return Container();
      },
    );
  }
}
