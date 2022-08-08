import 'package:calla/constants/constants.dart';
import 'package:calla/controllers/controllers.dart';
import 'package:calla/models/models.dart';
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

  final List<PlantModel> plants = [
    PlantModel(
      number: 1,
      name: "Jack",
      species: "Lily",
      lastWatered: DateTime.now(),
    ),
    PlantModel(
      number: 2,
      name: "Jack",
      species: "Lily",
      lastWatered: DateTime.now(),
    ),
    PlantModel(
      number: 3,
      name: "Jack",
      species: "Lily",
      lastWatered: DateTime.now(),
      isOff: true,
    ),
  ];

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
}
