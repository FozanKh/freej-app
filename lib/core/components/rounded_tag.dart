import 'package:flutter/material.dart';

import '../exports/core.dart';

class RoundedTag extends StatelessWidget {
  final String? title;
  final Color color;
  final bool elevated;
  final bool filled;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  const RoundedTag({
    this.title,
    this.color = kDark4,
    this.textStyle,
    this.elevated = false,
    this.filled = true,
    this.padding,
    this.margin,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      constraints: width == null ? const BoxConstraints(minWidth: 90) : null,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 2.5, horizontal: 10),
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: Borders.mBorderRadius,
        color: filled ? color : kTransparent,
        boxShadow: elevated ? Styles.boxShadow : null,
        border: filled ? null : Border.all(color: color, width: 2),
      ),
      child: Text(
        '$title',
        style: textStyle ??
            TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: filled ? kWhite : kFontsColor, height: 1.1),
        textAlign: TextAlign.center,
      ),
    );
  }
}
