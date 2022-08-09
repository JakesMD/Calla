import 'package:calla/controllers/app_controller.dart';
import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

/// A custom bottom sheet with a save button.
class MyBottomSheet extends StatelessWidget {
  final Widget child;
  final Function()? onSave;

  const MyBottomSheet({
    Key? key,
    required this.child,
    this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(MySizeTheme.pageMargin),
      decoration: BoxDecoration(
        color: AppCtl.to.colors.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(MySizeTheme.borderRadius30),
          topRight: Radius.circular(MySizeTheme.borderRadius30),
        ),
      ),
      child: SafeArea(
        top: false,
        child: MySpacedColumn(
          spacing: MySizeTheme.spacing25,
          children: [
            child,
            MyCircularIconButton(
              FeatherIcons.save,
              onTap: () {
                if (onSave != null) onSave!();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
