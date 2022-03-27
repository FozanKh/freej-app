import 'package:flutter/material.dart';

import '../exports/core.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final Color titleColor;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? margin;
  final Color? color;

  const ActionButton(
      {Key? key, required this.title, required this.onTap, this.margin, this.color, this.titleColor = kBackgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: Borders.sBorderRadius,
          color: color ?? kFontsColor,
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 12, color: titleColor, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
