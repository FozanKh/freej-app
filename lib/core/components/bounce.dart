import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Bounce extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;
  final bool enabled;
  const Bounce({Key? key, required this.child, required this.onTap, this.enabled = true}) : super(key: key);

  @override
  BounceState createState() => BounceState();
}

class BounceState extends State<Bounce> with SingleTickerProviderStateMixin {
  late double _scale;
  final Duration duration = const Duration(milliseconds: 100);

  late AnimationController _animate;

  Duration? onTapDownDuration;

  @override
  void initState() {
    _animate = AnimationController(vsync: this, duration: duration, lowerBound: 0.0, upperBound: 0.01)
      ..addListener(
        () {
          setState(() {});
        },
      );
    onTapDownDuration = Duration(milliseconds: duration.inMilliseconds + 150);
    super.initState();
  }

  @override
  void dispose() {
    _animate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animate.value;
    return GestureDetector(
      onTap: () async {
        if (widget.enabled) {
          HapticFeedback.lightImpact();
          _start(duration);
          widget.onTap();
        }
      },
      onTapDown: (details) => widget.enabled ? _start(onTapDownDuration) : null,
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }

  Future<void> _start(Duration? duration) async {
    _animate.forward();

    Future.delayed(duration ?? const Duration(milliseconds: 100), () {
      if (mounted && _animate.status != AnimationStatus.dismissed) _animate.reverse();
    });
  }
}
