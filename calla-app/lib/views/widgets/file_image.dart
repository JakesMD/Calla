import 'package:calla/controllers/app_controller.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';

// TODO: Add image with placeholder.

/// A custom image.
class MyFileImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const MyFileImage(
    this.path, {
    Key? key,
    this.width,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppCtl.to.colors.text.withOpacity(0.1),
        borderRadius: borderRadius,
      ),
      child: MyIcon(
        CupertinoIcons.photo,
        color: AppCtl.to.colors.background,
      ),
    );
  }
}
