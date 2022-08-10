import 'package:calla/controllers/app_controller.dart';
import 'package:calla/helpers/range.dart';
import 'package:calla/models/plant_model.dart';
import 'package:calla/services/file_service.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The controller that controls the [PlantPage].
class PlantPageCtl extends GetxController {
  /// The current instance of [PlantPageCtl].
  static final PlantPageCtl to = Get.find<PlantPageCtl>();

  /// The controller for the name text field in the [MyPlantPageEditProfileSheet].
  final nameController = TextEditingController();

  /// The controller for the species text field in the [MyPlantPageEditProfileSheet].
  final speciesController = TextEditingController();

  final Rx<PlantModel> _plant = PlantModel(number: 0).obs;
  final Rx<PlantModel> _tempPlant = PlantModel(number: 0).obs;

  /// The plant the [PlantPage] represents.
  PlantModel get plant => _plant.value;
  set plant(PlantModel newPlant) => _plant.value = newPlant;

  /// The temporary edited plant that will update the [plant].
  PlantModel get tempPlant => _tempPlant.value;
  set tempPlant(PlantModel newPlant) => _tempPlant.value = newPlant;

  /// Toggles and saves the [isOff] feature.
  void togglePower() {
    plant = plant.copyWith(isOff: !plant.isOff);
    AppCtl.to.savePlant();
  }

  /// Loads the [plant] into [tempPlant] and opens the [MyPlantPageEditProfileSheet].
  void showEditProfileSheet() {
    nameController.text = plant.name;
    speciesController.text = plant.species;
    FileSvc.to.tempImagePath = plant.fullPhotoPath();
    tempPlant = plant.copyWith();
    AppCtl.to.showBottomSheet(const MyPlantPageEditProfileSheet());
  }

  /// Loads the [plant] into [tempPlant] and opens the [MyPlantPageEditWaterSheet].
  void showEditWaterSheet() {
    tempPlant = plant.copyWith();
    AppCtl.to.showBottomSheet(const MyPlantPageEditWaterSheet());
  }

  /// Loads the [plant] into [tempPlant] and opens the [MyPlantPageEditLightSheet].
  void showEditLightSheet() {
    tempPlant = plant.copyWith();
    AppCtl.to.showBottomSheet(const MyPlantPageEditLightSheet());
  }

  /// Loads the [plant] into [tempPlant] and opens the [MyPlantPageEditTemperatureSheet].
  void showEditTemperatureSheet() {
    tempPlant = plant.copyWith();
    AppCtl.to.showBottomSheet(const MyPlantPageEditTemperatureSheet());
  }

  /// Loads the [plant] into [tempPlant] and opens the [MyPlantPageEditHumiditySheet].
  void showEditHumiditySheet() {
    tempPlant = plant.copyWith();
    AppCtl.to.showBottomSheet(const MyPlantPageEditHumiditySheet());
  }

  /// Updates the [preferredScheduledWater] and [preferredAutoWater] of the [tempPlant].
  void editWater(double val) {
    tempPlant = tempPlant.isWateringScheduled
        ? tempPlant.copyWith(preferredScheduledWater: val.toInt())
        : tempPlant.copyWith(preferredAutoWater: val / 100);
  }

  /// Updates the [wateringSchedule] of the [tempPlant].
  void editWateringSchedule(double val) {
    tempPlant = tempPlant.copyWith(wateringSchedule: val.toInt());
  }

  /// Updates the [isWateringScheduled] of the [tempPlant].
  void editIsWateringScheduled(bool val) {
    tempPlant = tempPlant.copyWith(isWateringScheduled: val);
  }

  /// Updates the [preferredLight] of the [tempPlant].
  void editLight(RangeValues val) {
    tempPlant = tempPlant.copyWith(preferredLight: Range(val.start, val.end));
  }

  /// Updates the [preferredTemperature] of the [tempPlant].
  void editTemperature(RangeValues val) {
    tempPlant = tempPlant.copyWith(preferredTemperature: Range(val.start, val.end));
  }

  /// Updates the [preferredHumidity] of the [tempPlant].
  void editHumidity(RangeValues val) {
    tempPlant = tempPlant.copyWith(preferredHumidity: Range(val.start, val.end));
  }

  /// Saves the [tempPlant] to the [plant], updates the plant in the [AppCtl] and saves it to local storage.
  void savePlant({bool savePhoto = false}) async {
    if (nameController.text.isNotEmpty) {
      tempPlant.name = nameController.text.trim();
      nameController.text = "";
    }
    if (speciesController.text.isNotEmpty) {
      tempPlant.species = speciesController.text.trim();
      speciesController.text = "";
    }

    if (savePhoto) {
      tempPlant = tempPlant.copyWith(photoPath: await FileSvc.to.saveTempImage());
    }

    plant = tempPlant.copyWith();

    AppCtl.to.savePlant();
  }
}
