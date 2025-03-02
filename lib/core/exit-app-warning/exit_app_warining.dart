import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trading/core/localization/localization.dart';

exitAppAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('WARNING'.tr(context)),
        content: Text('ALERT_CONTENT'.tr(context)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('CANCEL'.tr(context)),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: Text('CONFIRM'.tr(context)),
          )
        ],
      );
    },
  );
  // AwesomeDialog(
  //   context: context,
  //   dialogType: DialogType.info,
  //   animType: AnimType.rightSlide,
  //   title: 'WARNING'.tr(context),
  //   desc: 'ALERT_CONTENT'.tr(context),
  //   btnCancelOnPress: () {
  //     Navigator.of(context).pop();
  //   },
  //   btnOkOnPress: () {
  //     SystemNavigator.pop();
  //   },
  // ).show();
}
