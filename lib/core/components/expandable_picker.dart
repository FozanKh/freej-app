import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../exports/core.dart';

class ExpandablePicker extends StatefulWidget {
  const ExpandablePicker({
    Key? key,
    required this.title,
    this.onExpansionChanged,
    this.options = const <String>[],
    this.initiallyExpanded = false,
    this.padding,
    this.decoration,
    this.callback,
    this.value,
    this.isMultiSelect = false,
    this.enabled = true,
    this.borderRadius,
  }) : super(key: key);

  final String title;
  final String? value;
  final bool isMultiSelect;
  final bool enabled;
  final Function? callback;
  final ValueChanged<bool>? onExpansionChanged;
  final List<String> options;
  final bool initiallyExpanded;
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;
  final BorderRadius? borderRadius;

  @override
  ExpandablePickerState createState() => ExpandablePickerState();
}

class ExpandablePickerState extends State<ExpandablePicker> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _easeInAnimation;
  ColorTween? _iconColor;
  late Animation<double> _iconTurns;

  bool _isExpanded = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _easeInAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _iconColor = ColorTween();
    _iconTurns = Tween<double>(begin: 0.25, end: 0.75).animate(_easeInAnimation);

    _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void expand() {
    _setExpanded(true);
  }

  void collapse() {
    _setExpanded(false);
  }

  void toggle() {
    if (widget.enabled) {
      HapticFeedback.mediumImpact();
      _setExpanded(!_isExpanded);
    }
  }

  void _setExpanded(bool isExpanded) {
    if (_isExpanded != isExpanded) {
      setState(() {
        _isExpanded = isExpanded;
        if (_isExpanded) {
          _controller.forward();
        } else {
          _controller.reverse().then<void>((value) {
            setState(() {});
          });
        }
        PageStorage.of(context)?.writeState(context, _isExpanded);
      });
      if (widget.onExpansionChanged != null) {
        widget.onExpansionChanged!(_isExpanded);
      }
    }
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return Container(
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      decoration: widget.decoration ??
          BoxDecoration(
              borderRadius: widget.borderRadius ?? Borders.mBorderRadius, border: Border.all(color: Colors.grey)),
      foregroundDecoration: widget.decoration ??
          BoxDecoration(
              borderRadius: widget.borderRadius ?? Borders.mBorderRadius, border: Border.all(color: Colors.grey)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: Sizes.mCardHeight,
            child: IconTheme.merge(
              data: IconThemeData(color: _iconColor!.evaluate(_easeInAnimation)),
              child: InkWell(
                onTap: toggle,
                child: Padding(
                  padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        child: Text(
                          widget.value ?? widget.title,
                          style: TextStyle(
                            fontSize: 16,
                            color: widget.enabled && widget.value != null ? kFontsColor : kFontsColor.withOpacity(0.75),
                          ),
                        ),
                      ),
                      Flexible(
                        child: RotationTransition(
                          turns: _iconTurns,
                          child: Icon(
                            isArabic() ? Icons.chevron_left : Icons.chevron_right,
                            color: widget.enabled ? kFontsColor : kFontsColor.withOpacity(0.75),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ClipRect(
            child: Align(
              heightFactor: _easeInAnimation.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed
          ? null
          : Container(
              decoration: BoxDecoration(color: kLight2),
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 3),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: List.generate(
                    widget.options.length,
                    (index) => (!widget.isMultiSelect &&
                            (widget.options[index] == widget.value || widget.options[index].translate == widget.value))
                        ? const SizedBox()
                        : InkWell(
                            onTap: () {
                              toggle();
                              widget.callback!(index);
                            },
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(vertical: 7.5),
                              alignment: customAlignment(context),
                              child: Text((widget.options[index].translate), style: const TextStyle(fontSize: 16)),
                            ),
                          ),
                  ),
                ),
              ),
            ),
    );
  }
}
