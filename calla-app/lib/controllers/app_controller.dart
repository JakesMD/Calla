import 'package:calla/constants/constants.dart';
import 'package:calla/controllers/controllers.dart';
import 'package:calla/models/models.dart';
import 'package:calla/services/services.dart';
import 'package:calla/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// TODO: update this comment.

/// The controller that handles things like the color theme.
class AppCtl extends GetxController {
  /// The current instance of [AppCtl].
  static final AppCtl to = Get.find<AppCtl>();

  final Rx<MyColorTheme> _colors =
      Get.isDarkMode ? MyColorTheme.dark().obs : MyColorTheme.light().obs;

  final RxList<PlantModel> plants = [
    PrefsSvc.to.plant1,
    PrefsSvc.to.plant2,
    PrefsSvc.to.plant3,
  ].obs;

  final RxDouble _waterLevel = 0.25.obs;
  final RxDouble _light = 0.75.obs;
  final RxDouble _temperature = 25.0.obs;
  final RxDouble _humidity = 0.5.obs;

  /// The current color theme.
  MyColorTheme get colors => _colors.value;

  double get waterLevel => _waterLevel.value;
  double get light => _light.value;
  double get temperature => _temperature.value;
  double get humidity => _humidity.value;

  /// Initializes the [AppCtl] and returns an instance of it.
  Future<AppCtl> init() async {
    // Force orientation to portait.
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return this;
  }

  void goToPlantPage(int plantNumber) {
    PlantPageCtl.to.plant = plants[plantNumber - 1];
    Get.toNamed(AppRoutes.plant);
  }

  void showBottomSheet(Widget bottomSheet) {
    Get.bottomSheet(
      bottomSheet,
      enterBottomSheetDuration: MyDurationTheme.m250,
      exitBottomSheetDuration: MyDurationTheme.m250,
    );
  }

  /// Saves the edited plant from the [PlantPage].
  void savePlant() {
    plants[PlantPageCtl.to.plant.number - 1] = PlantPageCtl.to.plant;
    PrefsSvc.to.savePlant(PlantPageCtl.to.plant);
  }
}
