import 'package:flutter/material.dart';
import '../exports/core.dart';

class AlertDialogBox {
  static Future<void> showSnackBar(context, {required String message}) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  static Future<bool?> showAlert(context,
      {required String message, String title = '', String buttonTitle = 'ok'}) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return ShowUp(
          child: AlertDialog(
            title: title.isNotEmpty
                ? Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kFontsColor,
                    ),
                    textAlign: TextAlign.center,
                  )
                : null,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: kBackgroundColor,
            contentPadding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  if (title.isEmpty) const SizedBox(height: 5),
                  Center(
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: RoundedButton(
                      buttonColor: Colors.black,
                      title: buttonTitle.translate,
                      titleColor: Colors.white,
                      onTap: () => Nav.popPage(context, args: false),
                      height: Sizes.mCardHeight - 10,
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                      titleSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<bool?> showAssertionDialog(
    context, {
    String? message,
    bool locale = false,
    String title = '',
    String? continueButton,
    String? cancelButton,
    bool preferableChoice = true,
  }) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return ShowUp(
          child: AlertDialog(
            title: title != ''
                ? Text(
                    locale ? title.translate : title,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                : null,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: kBackgroundColor,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  if (message != null)
                    Center(
                      child: Text(
                        locale ? message.translate : message,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: RoundedButton(
                            buttonColor: kLight0,
                            title: cancelButton ?? 'cancel'.translate,
                            titleColor: kFontsColor,
                            onTap: () => Navigator.pop(context, false),
                            height: Sizes.mCardHeight - 10,
                            padding: EdgeInsets.zero,
                            titleSize: 14,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: RoundedButton(
                            buttonColor: preferableChoice ? kSecondaryColor : kRed2,
                            title: continueButton != null ? continueButton.translate : 'sure'.translate,
                            titleColor: kWhite,
                            onTap: () => Navigator.pop(context, true),
                            height: Sizes.mCardHeight - 10,
                            padding: EdgeInsets.zero,
                            titleSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<bool?> showCustomAlert(
    context, {
    String? title,
    String? message,
    bool locale = false,
    bool preferableChoice = true,
    bool isDismissible = false,
    String? continueButton,
    String? cancelButton,
    Function? onContinueButton,
  }) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: isDismissible, // user must tap button!
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => isDismissible,
          child: ShowUp(
            child: AlertDialog(
              title: title != null
                  ? Text(
                      locale ? title.translate : title,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  : null,
              shape: const RoundedRectangleBorder(borderRadius: const BorderRadius.all(const Radius.circular(20.0))),
              backgroundColor: kBackgroundColor,
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    if (message != null)
                      Center(
                        child: Text(
                          locale ? message.translate : message,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          if (isDismissible)
                            Expanded(
                              child: RoundedButton(
                                buttonColor: kLight0,
                                title: cancelButton != null ? cancelButton.translate : 'cancel'.translate,
                                titleColor: kFontsColor,
                                onTap: () => Navigator.pop(context, false),
                                height: Sizes.mCardHeight - 10,
                                padding: EdgeInsets.zero,
                                titleSize: 14,
                              ),
                            ),
                          if (isDismissible) const SizedBox(width: 20),
                          Expanded(
                            child: RoundedButton(
                              buttonColor: preferableChoice ? kPrimaryColor as Color? : kRed2,
                              title: continueButton != null ? continueButton.translate : 'sure'.translate,
                              titleColor: kWhite,
                              onTap: onContinueButton as void Function()? ?? () => Navigator.pop(context, true),
                              height: Sizes.mCardHeight - 10,
                              padding: EdgeInsets.zero,
                              titleSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
