import 'package:flutter/material.dart';

import '../exports/core.dart';

showCustomBottomSheet(
  context, {
  required Widget child,
  required String title,
  bool locale = false,
  ScrollPhysics? scrollPhysics,
  bool showCancelButton = false,
  bool isDismissible = true,
}) async {
  return showModalBottomSheet(
    isScrollControlled: true,
    elevation: 0,
    useRootNavigator: true,
    enableDrag: isDismissible,
    isDismissible: isDismissible,
    backgroundColor: kTransparent,
    context: context,
    builder: (context) => AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        color: kBackgroundColor,
      ),
      margin: const EdgeInsets.only(
        top: kToolbarHeight + 10,
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).padding.bottom + 50,
        right: 20,
        left: 20,
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: scrollPhysics ?? const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[const SizedBox(height: kToolbarHeight + 40), child],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              boxShadow: [BoxShadow(color: kBackgroundColor, blurRadius: 5, offset: Offset(0, 10))],
              color: kBackgroundColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Container(
                  height: 5,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: Borders.mBorderRadius,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(locale ? title : title,
                        style: const TextStyle(fontSize: 18, color: kFontsColor, fontWeight: FontWeight.w600)),
                    if (showCancelButton)
                      ActionButton(
                        title: 'cancel'.translate,
                        onTap: () => Navigator.pop(context),
                      )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
