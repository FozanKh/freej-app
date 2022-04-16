import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../exports/core.dart';

enum ProgressDialogType { Normal, Download }

class ProgressDialog {
  static double _maxProgress = 100.0;
  static int _timeout = 6;
  static Alignment _progressWidgetAlignment = Alignment.centerLeft;
  static bool? _isShowing = false;
  static late BuildContext _context;
  static late BuildContext _dismissingContext;
  static bool _barrierDismissible = true, _showLogs = false;
  static double _dialogElevation = 8.0, _borderRadius = 8.0;
  static Color _backgroundColor = Colors.white;
  static Curve _insetAnimCurve = Curves.easeInOut;
  static EdgeInsets _dialogPadding = const EdgeInsets.all(8.0);
  static Widget? mainProgressWidget = Lottie.asset(Assets.kLoadingAnimationAsset, height: 50, width: 50);
  static _Body? _dialog;

  ProgressDialog(BuildContext context,
      {ProgressDialogType? type, bool? isDismissible, bool? showLogs, Widget? customBody, int? timeout}) {
    _context = context;
    _barrierDismissible = isDismissible ?? true;
    _showLogs = showLogs ?? false;
    _timeout = timeout ?? _timeout;
  }

  void style(
      {Widget? child,
      double? progress,
      double? maxProgress,
      String? message,
      Widget? progressWidget,
      Color? backgroundColor,
      TextStyle? progressTextStyle,
      TextStyle? messageTextStyle,
      double? elevation,
      TextAlign? textAlign,
      double? borderRadius,
      Curve? insetAnimCurve,
      EdgeInsets? padding,
      Alignment? progressWidgetAlignment}) {
    if (ProgressDialog._isShowing!) return;

    _maxProgress = maxProgress ?? _maxProgress;
    mainProgressWidget = progressWidget ?? mainProgressWidget;
    _backgroundColor = backgroundColor ?? _backgroundColor;
    _dialogElevation = elevation ?? _dialogElevation;
    _borderRadius = borderRadius ?? _borderRadius;
    _insetAnimCurve = insetAnimCurve ?? _insetAnimCurve;
    mainProgressWidget = child ?? mainProgressWidget;
    _dialogPadding = padding ?? _dialogPadding;
    _progressWidgetAlignment = progressWidgetAlignment ?? _progressWidgetAlignment;
  }

  bool? isShowing() {
    return ProgressDialog._isShowing;
  }

  Future<bool> hide() async {
    try {
      if (ProgressDialog._isShowing!) {
        ProgressDialog._isShowing = false;
        if (Navigator.of(ProgressDialog._dismissingContext).canPop()) {
          Navigator.of(ProgressDialog._dismissingContext).pop();
        }
        if (ProgressDialog._showLogs) debugPrint('ProgressDialog dismissed');
        return Future.value(true);
      } else {
        if (ProgressDialog._showLogs) debugPrint('ProgressDialog already dismissed');
        return Future.value(false);
      }
    } catch (err) {
      debugPrint('Seems there is an issue hiding dialog');
      debugPrint(err.toString());
      return Future.value(false);
    }
  }

  Future<bool> show() async {
    try {
      ProgressDialog._isShowing ??= false;
      if (!ProgressDialog._isShowing!) {
        _dialog = _Body();
        showDialog<dynamic>(
          context: _context,
          barrierDismissible: false, //_barrierDismissible,
          builder: (BuildContext context) {
            ProgressDialog._dismissingContext = context;
            return WillPopScope(
              onWillPop: () async => _barrierDismissible,
              child: Center(child: _dialog),
            );
          },
        );
        // Delaying the function for 200 milliseconds
        // [Default transitionDuration of DialogRoute]
        await Future.delayed(const Duration(milliseconds: 200));
        if (ProgressDialog._showLogs) debugPrint('ProgressDialog shown');
        ProgressDialog._isShowing = true;
        return true;
      } else {
        if (ProgressDialog._showLogs) debugPrint("ProgressDialog already shown/showing");
        return false;
      }
    } catch (err) {
      ProgressDialog._isShowing = false;
      debugPrint('Exception while showing the dialog');
      debugPrint(err.toString());
      return false;
    }
  }
}

// ignore: must_be_immutable
class _Body extends StatefulWidget {
  final _BodyState _dialog = _BodyState();

  Future<bool> hide() async {
    try {
      if (ProgressDialog._isShowing!) {
        ProgressDialog._isShowing = false;
        if (Navigator.of(ProgressDialog._dismissingContext).canPop()) {
          Navigator.of(ProgressDialog._dismissingContext).pop();
        }
        if (ProgressDialog._showLogs) debugPrint('ProgressDialog dismissed');
        return Future.value(true);
      } else {
        if (ProgressDialog._showLogs) debugPrint('ProgressDialog already dismissed');
        return Future.value(false);
      }
    } catch (err) {
      debugPrint('Seems there is an issue hiding dialog');
      debugPrint(err.toString());
      return Future.value(false);
    }
  }

  @override
  State<StatefulWidget> createState() {
    return _dialog;
  }
}

class _BodyState extends State<_Body> {
  bool isCancelShown = false;

  update() {
    setState(() {});
  }

  @override
  void dispose() {
    ProgressDialog._isShowing = null;
    if (ProgressDialog._showLogs) debugPrint('ProgressDialog dismissed by back button');
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: ProgressDialog._timeout)).then((value) {
      if (ProgressDialog._isShowing != null) {
        isCancelShown = true;

        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kTransparent,
      child: Container(
        padding: ProgressDialog._dialogPadding,
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Dialog(
                backgroundColor: kTransparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(width: 8.0),
                Align(
                  alignment: ProgressDialog._progressWidgetAlignment,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    width: 200.0,
                    height: 200.0,
                    child: ProgressDialog.mainProgressWidget,
                  ),
                ),
                const SizedBox(width: 8.0),
              ],
            ),
            Visibility(
              visible: isCancelShown,
              child: ShowUp(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: RoundedButton(
                    title: "cancel".translate,
                    buttonColor: kFontsColor,
                    titleColor: kWhite,
                    onTap: () => widget.hide(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
