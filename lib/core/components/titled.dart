import 'package:flutter/material.dart';

import '../exports/core.dart';

class Titled extends StatelessWidget {
  final String title;
  final Widget? titleIcon;
  final Color? titleColor;
  final TextStyle? titleTextStyle;
  final Widget? child;
  final Widget? trailing;
  final bool largeTitle;
  final EdgeInsets? padding;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const Titled({
    Key? key,
    required this.title,
    this.titleColor,
    this.titleTextStyle,
    this.child,
    this.trailing,
    this.largeTitle = false,
    this.titleIcon,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft.relative(),
          padding: padding ?? EdgeInsets.symmetric(horizontal: largeTitle ? 20 : 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: titleTextStyle?.color ?? titleColor ?? (largeTitle ? kFontsColor : Colors.grey),
                  fontSize: titleTextStyle?.fontSize ?? (largeTitle ? 24 : 12),
                  fontWeight: titleTextStyle?.fontWeight ?? (largeTitle ? FontWeight.w700 : null),
                  height: titleTextStyle?.height,
                  decoration: titleTextStyle?.decoration,
                ),
              ),
              if (titleIcon != null) titleIcon!,
              const Spacer(),
              if (trailing != null) trailing!,
            ],
          ),
        ),
        const SizedBox(height: 5),
        if (child != null) child!
      ],
    );
  }
}
