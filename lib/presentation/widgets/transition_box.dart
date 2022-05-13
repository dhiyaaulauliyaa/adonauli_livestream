import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:show_up_animation/show_up_animation.dart';

import 'hidden_widget.dart';

class TransitionBox extends StatelessWidget {
  const TransitionBox({
    Key? key,
    required this.child,
    this.show = true,
    this.startDelay = Duration.zero,
    this.duration = const Duration(milliseconds: 2000),
    this.direction = Direction.horizontal,
    this.curve = Curves.easeOutCirc,
    this.offset = -1,
  }) : super(key: key);

  final bool show;
  final Widget child;
  final Duration startDelay;
  final Duration duration;
  final Direction direction;
  final Curve curve;
  final double offset;

  @override
  Widget build(BuildContext context) {
    if (show) {
      return _buildWidget();
    } else {
      return HiddenWidget(child: child);
    }
    // return AnimatedSwitcher(
    //   duration: Duration(milliseconds: show ? 200 : 0),
    //   child: show
    //       ? newMethod()
    //       : HiddenWidget(
    //           child: child,
    //         ),
    // );
  }

  Widget _buildWidget() {
    return ShowUpAnimation(
      animationDuration: duration,
      curve: curve,
      delayStart: startDelay,
      direction: direction,
      offset: offset,
      child: child,
    );
    // return AnimatedContainer(
    //   duration: duration,
    //   transform: getTransform(show),
    //   child: child,
    // );
  }

  // getTransform(bool show) {
  //   if (show) {
  //     return Matrix4.identity();
  //   } else {
  //     return Matrix4.identity()
  //       ..translate(-1.sw, 0)
  //       ..scale(1, 1);
  //   }
  // }
}
