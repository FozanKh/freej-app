import 'package:flutter/material.dart';

import '../../exports/core.dart';

/// Shimmer Effect is used for loading the widget in an attractive form
class Shimmer extends StatefulWidget {
  final Widget child, placeholder;
  final bool isLoading;

  const Shimmer({Key? key, required this.child, required this.isLoading, required this.placeholder}) : super(key: key);

  @override
  _ShimmerState createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500))
      ..forward()
      ..repeat(reverse: true);
    animation = Tween(begin: 1.0, end: 0.2).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(seconds: 1),
      crossFadeState: (widget.isLoading) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: FadeTransition(
        opacity: animation as Animation<double>,
        child: widget.placeholder,
      ),
      secondChild: Builder(builder: (context) {
        if (!widget.isLoading) controller.stop();
        return widget.child;
      }),
    );
  }
}

class PlaceHolderContainer extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final double? height, width;
  final bool isRounded;
  final BoxDecoration? boxDecoration;
  const PlaceHolderContainer(
      {Key? key, this.height, this.width, this.isRounded = true, this.margin, this.boxDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width ?? MediaQuery.of(context).size.width * 0.4,
      height: height ?? MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        color: boxDecoration?.color ?? Colors.grey[300],
        shape: boxDecoration?.shape ?? BoxShape.rectangle,
        border: boxDecoration?.border,
        boxShadow: boxDecoration?.boxShadow,
        image: boxDecoration?.image,
        backgroundBlendMode: boxDecoration?.backgroundBlendMode,
        gradient: boxDecoration?.gradient,
        borderRadius:
            boxDecoration?.shape == BoxShape.circle ? null : boxDecoration?.borderRadius ?? Borders.mBorderRadius,
      ),
    );
  }
}
