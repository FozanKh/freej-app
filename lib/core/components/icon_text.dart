import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextStyle? style;
  final Color? iconColor;
  final double? iconSize;

  const IconText({Key? key, required this.icon, required this.text, this.style, this.iconColor, this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: iconColor ?? style?.color,
          size: iconSize,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          maxLines: 1,
          style: style,
        )
      ],
    );
  }
}
