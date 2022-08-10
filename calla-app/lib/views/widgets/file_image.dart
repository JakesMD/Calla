import 'dart:io';

import 'package:calla/controllers/app_controller.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';

/// A custom image.
class MyFileImage extends StatelessWidget {
  /// If "" the place holder will be shown.
  final String path;
  final double? width;
  final double? height;
  final double opacity;
  final BorderRadius? borderRadius;

  const MyFileImage(
    this.path, {
    Key? key,
    this.width,
    this.height,
    this.opacity = 1,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: width,
        height: height,
        decoration: BoxDecoration(borderRadius: borderRadius),
        child: path.isNotEmpty
            ? Image.file(
                File(path),
                fit: BoxFit.cover,
                height: height,
                width: width,
                errorBuilder: (context, error, stackTrace) => _placeHolder(),
              )
            : _placeHolder(),
      ),
    );
  }

  /// A placeholder for when the file doesn't exist or an error has occured.
  Widget _placeHolder() {
    return Container(
      decoration: BoxDecoration(
        color: AppCtl.to.colors.text.withOpacity(0.1),
      ),
      child: MyIcon(
        CupertinoIcons.photo,
        color: AppCtl.to.colors.background,
      ),
    );
  }
}
