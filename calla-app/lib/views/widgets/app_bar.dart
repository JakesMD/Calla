import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// A custom app bar with 2 [MyCircularIconButton]s. The second one is optional.
class MyAppBar extends StatelessWidget {
  final IconData leftIcon;
  final IconData? rightIcon;
  final Function()? onLeftIconTap;
  final Function()? onRightIconTap;

  const MyAppBar({
    Key? key,
    required this.leftIcon,
    this.rightIcon,
    this.onLeftIconTap,
    this.onRightIconTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MySpacedRow(
      children: [
        MyCircularIconButton(
          leftIcon,
          onTap: onLeftIconTap,
        ),
        const Spacer(),
        if (rightIcon != null)
          MyCircularIconButton(
            rightIcon!,
            onTap: onRightIconTap,
          ),
      ],
    );
  }
}
