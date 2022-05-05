import 'package:flutter/material.dart';

import '../exports/core.dart';

showCustomBottomSheet(
  context, {
  required Widget child,
  required String title,
  ScrollPhysics? scrollPhysics,
  bool showCancelButton = false,
  bool isDismissible = true,
  bool scrollable = true,
  Widget? persistentFooter,
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
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: kToolbarHeight + 10,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kGrey,
                  width: 0.2,
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                    Text(
                      title,
                      style: TextStyles.t1,
                      maxLines: 1,
                    ),
                    if (showCancelButton)
                      ActionButton(
                        title: 'cancel'.translate,
                        onTap: () => Navigator.pop(context),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: scrollable
                ? SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 10),
                    physics: scrollPhysics ?? const BouncingScrollPhysics(),
                    child: child,
                  )
                : child,
          ),
          if (persistentFooter != null) persistentFooter
        ],
      ),
    ),
  );
}
