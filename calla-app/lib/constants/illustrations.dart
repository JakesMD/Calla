import 'package:calla/controllers/app_controller.dart';
import 'package:calla/services/services.dart';
import 'package:calla/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final lightTheme = MyColorTheme.light();
final darkTheme = MyColorTheme.dark();

/// All the available illustrations.
enum Illustrations {
  environment;

  /// The new colors to be replaced with.
  List<Color> get colors =>
      _illustrationColorsMap["$name${Get.isDarkMode ? "Dark" : "Light"}"]!;

  /// The source code of the svg file.
  String get code => AssetSvc.to.illustrations[this]!;
}

// A map with all the new colors for each illustration in light and dark mode.
final Map<String, List<Color>> _illustrationColorsMap = {
  "environmentLight": [
    AppCtl.to.colors.orange, // Hands
    AppCtl.to.colors.pink, // Sleeves
    AppCtl.to.colors.text, // Soil
    AppCtl.to.colors.green, // Leaves
  ],
  "environmentDark": [
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
  ],
};
