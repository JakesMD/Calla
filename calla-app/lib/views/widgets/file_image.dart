import 'package:calla/controllers/app_controller.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';

// TODO: Add image with placeholder.

/// A custom image.
class MyFileImage extends StatelessWidget {
  final String path;
  const MyFileImage(this.path, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppCtl.to.colors.text.withOpacity(0.15),
      child: MyIcon(
        CupertinoIcons.photo,
        color: AppCtl.to.colors.background,
      ),
    );
  }
}
