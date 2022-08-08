import 'package:calla/models/plant_model.dart';
import 'package:calla/themes/themes.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// TODO: update this comment.

/// The controller that handles things like the color theme.
class AppCtl extends GetxController {
  /// The current instance of [AppCtl].
  static final AppCtl to = Get.find<AppCtl>();

  final Rx<MyColorTheme> _colors =
      Get.isDarkMode ? MyColorTheme.dark().obs : MyColorTheme.light().obs;

  final Rx<PlantModel> _plant1 = PlantModel(
    number: 1,
    name: "Jack",
    type: "Lily",
    lastWatered: DateTime.now(),
  ).obs;

  final Rx<PlantModel> _plant2 = PlantModel(
    number: 2,
    name: "Jack",
    type: "Lily",
    lastWatered: DateTime.now(),
  ).obs;

  final Rx<PlantModel> _plant3 = PlantModel(
    number: 3,
    name: "Jack",
    type: "Lily",
    lastWatered: DateTime.now(),
  ).obs;

  /// The current color theme.
  MyColorTheme get colors => _colors.value;

  PlantModel get plant1 => _plant1.value;
  PlantModel get plant2 => _plant2.value;
  PlantModel get plant3 => _plant3.value;

  /// Initializes the [AppCtl] and returns an instance of it.
  Future<AppCtl> init() async {
    // Force orientation to portait.
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return this;
  }
}
