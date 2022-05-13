import 'package:flutter/material.dart';

class HiddenWidget extends StatelessWidget {
  const HiddenWidget({
    Key? key,
    required this.child,
    this.duration = Duration.zero,
    this.hide = true,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final bool hide;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: hide == true,
      child: AnimatedOpacity(
        duration: duration,
        opacity: hide ? 0 : 1,
        child: child,
      ),
    );
  }
}
