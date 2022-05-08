import 'package:flutter/material.dart';

class SeparatedColumn extends StatelessWidget {
  final List<Widget> children;
  final TextBaseline? textBaseline;
  final TextDirection? textDirection;
  final MainAxisSize mainAxisSize;
  final VerticalDirection verticalDirection;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Widget separator;
  final EdgeInsets? contentPadding;
  final EdgeInsets? margin;
  final bool startingSeparator;
  final bool trailingSeparator;

  const SeparatedColumn({
    Key? key,
    required this.separator,
    this.children = const <Widget>[],
    this.mainAxisSize = MainAxisSize.max,
    this.verticalDirection = VerticalDirection.down,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.textBaseline,
    this.contentPadding,
    this.margin,
    this.startingSeparator = false,
    this.trailingSeparator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    if (this.children.isNotEmpty) {
      if (startingSeparator) children.add(separator);

      for (int i = 0; i < this.children.length; i++) {
        children.add(Padding(
          padding: contentPadding ?? EdgeInsets.zero,
          child: this.children[i],
        ));

        if (this.children.length - i != 1) {
          children.add(separator);
        }
      }
      if (trailingSeparator) children.add(separator);
    }

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Column(
        key: key,
        children: children,
        mainAxisSize: mainAxisSize,
        textBaseline: textBaseline,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
      ),
    );
  }
}
