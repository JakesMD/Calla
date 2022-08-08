import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

export 'package:calla/constants/illustrations.dart';

/// An [SVGPicture] that displays the given [illustration] with optional [text] below.
class MyIllustration extends StatelessWidget {
  final Illustrations illustration;

  final double? width;
  final double? height;

  const MyIllustration(
    this.illustration, {
    Key? key,
    this.width,
    this.height = MySizeTheme.illustrationHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyColoredSVG(
      code: illustration.code,
      colors: illustration.colors,
      width: width,
      height: height,
    );
  }
}
