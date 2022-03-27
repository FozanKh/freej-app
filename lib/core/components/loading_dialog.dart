import 'package:flutter/material.dart';
import 'package:freej/core/constants/colors.dart';
import 'package:freej/core/constants/decorations.dart';
import 'package:lottie/lottie.dart';

import '../constants/assets.dart';

class LoadingDialog {
  /// [_msg] Listens to the msg value.
  // Value assignment is done later.
  final String? message;

  /// [_dialogIsOpen] Shows whether the dialog is open.
  //  Not directly accessible.
  bool _dialogIsOpen = false;

  /// [loadingAnimation] Saves the loading Animation for later use.
  //  Not directly accessible.
  late final _loadingAnimation = Lottie.asset(Assets.kLoadingAnimationAsset);

  /// [_context] Required to show the alert.
  // Can only be accessed with the constructor.
  late BuildContext _context;

  LoadingDialog({this.message, required context}) {
    _context = context;
  }

  /// [close] Closes the progress dialog.
  void close() {
    if (_dialogIsOpen) {
      Navigator.pop(_context);
      _dialogIsOpen = false;
    }
  }

  ///[isOpen] Returns whether the dialog box is open.
  bool isOpen() {
    return _dialogIsOpen;
  }

  show({
    String? message,
    Color barrierColor = kTransparent,
    bool barrierDismissible = true,
  }) {
    _dialogIsOpen = true;
    return showDialog(
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      context: _context,
      builder: (context) => WillPopScope(
        onWillPop: () => Future.value(
          barrierDismissible,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width / 3,
              child: _loadingAnimation,
            ),
            if (message != null)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    top: 8.0,
                    bottom: 8.0,
                  ),
                  child: Text(
                    message,
                    style: TextStyles.body3,
                  ),
                ),
              ),
          ],
        ),
        // child: AlertDialog(
        //   // backgroundColor: backgroundColor,
        //   // elevation: elevation,
        //   // shape: RoundedRectangleBorder(
        //   //   borderRadius: BorderRadius.all(
        //   //     Radius.circular(borderRadius),
        //   //   ),
        //   // ),
        //   content: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Expanded(
        //         child: Padding(
        //           padding: const EdgeInsets.only(
        //             left: 15.0,
        //             top: 8.0,
        //             bottom: 8.0,
        //           ),
        //           child: Text(
        //             _msg.value,
        //             maxLines: msgMaxLines,
        //             overflow: TextOverflow.ellipsis,
        //             style: TextStyle(
        //               fontSize: msgFontSize,
        //               color: msgColor,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
      ),
    );
  }
}
