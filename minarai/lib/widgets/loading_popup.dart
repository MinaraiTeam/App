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
    // Register a callback for when this widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      maybeShowDialog();
    });
  }

  void maybeShowDialog() {
    if (mounted) {
      var appData = Provider.of<AppData>(context, listen: false);
      if (appData.isCharging) {
        Future.microtask(() => showDialogIfCurrent(context, appData));
      }
    }
  }

  void showDialogIfCurrent(BuildContext context, AppData appData) {
    if (ModalRoute.of(context)?.isCurrent ?? false) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Config.backgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  UiTextManager.uiT.ui['loading_${appData.language}'],
                  style: TextStyle(color: Config.fontText, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use a Consumer to react to changes in AppData
    return Consumer<AppData>(
      builder: (_, appData, __) {
        // Respond to changes in isCharging by attempting to show the dialog
        if (appData.isCharging) {
          maybeShowDialog();
        } else {
          // Close the dialog if it's open and the condition is no longer met
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        }
        return SizedBox.shrink();  // Render an empty container when not needed
      },
    );
  }
}
