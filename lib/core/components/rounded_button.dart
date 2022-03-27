import 'package:flutter/material.dart';

import '../exports/core.dart';

class RoundedButton extends StatelessWidget {
  final Color? buttonColor;
  final Widget? child;
  final String? title;
  final double? titleSize;
  final Color? titleColor;
  final Color? borderColor;
  final Gradient? gradient;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final TextStyle? textStyle;
  final bool enabled;
  final bool elevated;
  final void Function() onTap;

  const RoundedButton({
    Key? key,
    required this.onTap,
    this.buttonColor,
    this.title,
    this.titleColor,
    this.child,
    this.margin,
    this.padding,
    this.titleSize,
    this.borderRadius,
    this.borderColor,
    this.height,
    this.enabled = true,
    this.textStyle,
    this.gradient,
    this.elevated = false,
  })  : assert(child == null || title == null),
        assert(child != null || title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      enabled: enabled,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: height ?? Sizes.mCardHeight,
        alignment: Alignment.center,
        margin: margin ?? const EdgeInsets.only(top: 10),
        padding: padding ?? const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: borderRadius ?? Borders.mBorderRadius,
          color: borderColor == null
              ? enabled
                  ? buttonColor ?? kPrimaryColor
                  : Colors.grey
              : kTransparent,
          border: borderColor != null ? Border.all(color: borderColor!, width: 2) : null,
          boxShadow: elevated ? Styles.boxShadow : null,
        ),
        child: child ??
            Text(
              title!,
              style: textStyle ?? TextStyle(fontSize: titleSize ?? 16, color: titleColor ?? kWhite),
              textAlign: TextAlign.center,
            ),
      ),
    );
  }
}
