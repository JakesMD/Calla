import 'package:calla/themes/themes.dart';
import 'package:flutter/material.dart';

/// A Widget that transitions between children when the child changes.
class MyAnimatedSwitcher extends StatelessWidget {
  final Widget child;
  final Duration duration;

  /// Defaults to AnimatedSwitcher.defaultTransitionBuilder.
  final Widget Function(Widget, Animation<double>)? transitionBuilder;

  const MyAnimatedSwitcher({
    Key? key,
    required this.child,
    this.duration = MyDurationTheme.m250,
    this.transitionBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: transitionBuilder ?? AnimatedSwitcher.defaultTransitionBuilder,

      // This stops the new child from jumping about if it has a smaller size.
      layoutBuilder: (currentChild, previousChildren) => Stack(
        alignment: Alignment.topCenter,
        children: [
          ...previousChildren,
          if (currentChild != null) currentChild,
        ],
      ),

      switchInCurve: MyCurveTheme.ease,
      switchOutCurve: MyCurveTheme.ease,

      child: child,
    );
  }
}
