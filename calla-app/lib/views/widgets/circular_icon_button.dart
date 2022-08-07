import 'package:calla/controllers/controllers.dart';
import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// An icon button in a circular container.
class MyCircularIconButton extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;

  const MyCircularIconButton(this.icon, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyClickable(
      height: MySizeTheme.buttonHeight,
      width: MySizeTheme.buttonHeight,
      borderRadius: MySizeTheme.buttonHeight / 2,
      color: AppCtl.to.colors.orange.withOpacity(0.5),
      onTap: onTap,
      child: MyIcon(icon),
    );
  }
}
