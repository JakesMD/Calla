import 'package:calla/themes/themes.dart';
import 'package:flutter/material.dart';

/// A [Row] that spaces its [children] with the given [spacing].
class MySpacedRow extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsets padding;

  const MySpacedRow({
    Key? key,
    required this.children,
    this.spacing = MySizeTheme.spacing15,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> spacedChildren = [];
    for (Widget child in children) {
      spacedChildren.add(child);
      spacedChildren.add(SizedBox(width: spacing));
    }
    if (spacedChildren.isNotEmpty) {
      spacedChildren.removeLast(); // Removes the last spacer.
    }

    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        children: spacedChildren,
      ),
    );
  }
}
