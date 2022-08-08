import 'package:calla/themes/themes.dart';
import 'package:flutter/material.dart';

/// A [Column] that spaces its [children] with the given [spacing].
class MySpacedColumn extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsets padding;

  const MySpacedColumn({
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
    var spacedChildren = <Widget>[];
    for (var child in children) {
      spacedChildren.add(child);
      spacedChildren.add(SizedBox(height: spacing));
    }
    if (spacedChildren.isNotEmpty) {
      spacedChildren.removeLast();
    }

    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        children: spacedChildren,
      ),
    );
  }
}
