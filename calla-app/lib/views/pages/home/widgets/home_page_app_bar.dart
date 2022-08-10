import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

/// The app bar at the top of the [HomePage].
class MyHomePageAppBar extends StatelessWidget {
  const MyHomePageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MySpacedRow(
      padding: const EdgeInsets.symmetric(horizontal: MySizeTheme.pageMargin),
      children: [
        Expanded(
          child: Text(
            "Hi there!".tr,
            style: MyTextTheme.headline1,
          ),
        ),
        const MyCircularIconButton(FeatherIcons.settings),
      ],
    );
  }
}
