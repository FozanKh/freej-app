import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:freej/core/localization/constants.dart';

import '../components/alert_dialog_box.dart';

class Nav {
  static final GlobalKey mainScaffoldNavbarKey = GlobalKey(debugLabel: 'main_scaffold_navbar');
  static Future<dynamic> openPage({
    required BuildContext context,
    required Widget page,
    bool isAnimated = false,
    bool isPushReplaced = false,
    Map<String, dynamic>? args,
    bool useRootNavigator = true,
  }) async {
    if (isPushReplaced) {
      return await Navigator.of(context, rootNavigator: !useRootNavigator).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return page;
          },
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            return Align(
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        ),
      );
    }

    if (!isAnimated) {
      return await Navigator.of(context, rootNavigator: !useRootNavigator)
          .push(CupertinoPageRoute(builder: (context) => page));
    } else if (isAnimated) {
      return await Navigator.of(context, rootNavigator: !useRootNavigator).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return page;
          },
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            return Align(
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        ),
      );
    }
  }

  static Future<dynamic> popPage(context, {args}) async {
    return Navigator.pop(context, args);
  }

  static void switchTab(int page) {
    (mainScaffoldNavbarKey.currentWidget as BottomNavigationBar).onTap!(page);
  }

  static openUrl(context, {required String url, String? errorMsg}) async {
    if (await launcher.canLaunch(url)) {
      launcher.launch(url, enableJavaScript: true);
    } else {
      log("Couldn't open $url");
      await AlertDialogBox.showAlert(context, message: errorMsg ?? "general_api_error".translate);
    }
  }
}
