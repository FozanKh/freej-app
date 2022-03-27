import 'dart:async';
import 'package:flutter/material.dart';

class FadeIn extends StatefulWidget {
  final Widget child;
  final int? delay;
  final Duration? duration;

  const FadeIn({Key? key, this.delay, required this.child, this.duration}) : super(key: key);

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with TickerProviderStateMixin {
  late AnimationController _animController;
  bool _animControllerDipsos = false;
  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: widget.duration ?? const Duration(milliseconds: 600));
    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay!), () {
        if (!_animControllerDipsos) _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    _animControllerDipsos = true;
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: widget.child,
      opacity: _animController,
    );
  }
}
