import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// An [SvgPicture] that replaces its original colors with the given [colors].
class MyColoredSVG extends StatefulWidget {
  /// The source code of the svg file.
  final String code;

  /// The colors you want to replace with.
  final List<Color> colors;

  final double? width;
  final double? height;

  const MyColoredSVG({
    Key? key,
    required this.code,
    required this.colors,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<MyColoredSVG> createState() => _MyColoredSVGState();
}

class _MyColoredSVGState extends State<MyColoredSVG> {
  /// The expression that matches a hex color in the svg code.
  final _hexReg = RegExp(r'fill=\"#([0-9a-fA-F]{6}|[0-9a-fA-F]{3})\"');

  /// The svg code with the replaced colors.
  String _modifiedCode = '';

  /// Generates a hex string from the given [color].
  String _colorToHex(Color color) =>
      '#${color.value.toRadixString(16).substring(2)}';

  /// Matches all the colors in the svg [code] and replaces them with the given [colors].
  String _replaceColors({required String code, required List<Color> colors}) {
    // Find all the colors in the svg code.
    var matches = _hexReg.allMatches(code);

    // Stores the colors that have been replaced already.
    var replacedColors = <String>[];

    // Loop through all the found colors.
    for (var match in matches) {
      // True, if the color hasn't already been replaced.
      if (!replacedColors.contains(match.group(0)!)) {
        // Fetch the next color from the colors list and convert it to hex.
        var newHex = _colorToHex(widget.colors[replacedColors.length]);

        // Replace the old color with the new color.
        code = code.replaceAll(match.group(0)!, "fill=\"$newHex\"");

        // Add the old color to the list of replaced colors.
        replacedColors.add(match.group(0)!);
      }
    }
    return code;
  }

  @override
  void initState() {
    // Replace the colors in the svg code before the widget is built.
    _modifiedCode = _replaceColors(code: widget.code, colors: widget.colors);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: SvgPicture.string(
        _modifiedCode,
        width: widget.width,
        height: widget.height,
      ),
    );
  }
}
