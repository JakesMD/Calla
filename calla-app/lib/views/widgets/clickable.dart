import 'package:flutter/material.dart';

/// A container that displays a splash effect when tapped.
class MyClickable extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final Function()? onTap;

  const MyClickable({
    Key? key,
    this.child,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.padding,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: Ink(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: color != null ? (onTap != null ? color : color!.withOpacity(0.5)) : null,
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
        child: Center(child: child),
      ),
    );
  }
}
