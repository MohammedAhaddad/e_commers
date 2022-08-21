// ignore: file_names
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../router/router.dart';

class Dailog {
  static showDailog(String s) {
    showDialog(
        context: AppRouter.navKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            content: Text(s),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(AppRouter.navKey.currentContext!).pop();
                  },
                  child: Text("ok".tr()))
            ],
          );
        });
  }
}
