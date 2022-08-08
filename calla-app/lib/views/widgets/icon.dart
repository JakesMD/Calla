import 'package:calla/controllers/controllers.dart';
import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// A customized animated icon button.
class MyIcon extends StatelessWidget {
  final IconData icon;
  final double size;

  /// Defaults to AppCtl.to.colors.text.
  final Color? color;

  final Function()? onTap;

  const MyIcon(
    this.icon, {
    Key? key,
    this.size = MySizeTheme.icon25,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyClickable(
      onTap: onTap,
      width: size,
      height: size,
      borderRadius: size / 2,
      child: MyAnimatedSwitcher(
          child: Icon(
        icon,
        key: Key("$icon$color$size$onTap"),
        color: color ?? AppCtl.to.colors.text,
        size: size,
      )),
    );
  }
}
