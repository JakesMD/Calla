import 'package:calla/models/plant_model.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The controller that controls the [PlantPage].
class PlantPageCtl extends GetxController {
  /// The current instance of [PlantPageCtl].
  static final PlantPageCtl to = Get.find<PlantPageCtl>();

  final nameController = TextEditingController();
  final speciesController = TextEditingController();

  final Rx<String> _tempPhotoPath = "".obs;

  final Rx<PlantModel> _plant = PlantModel(
    number: 0,
    name: "",
    species: "",
  ).obs;

  /// A the path of the temp photo on the [MyPlantPageEditProfileSheet].
  String get tempPhotoPath => _tempPhotoPath.value;

  PlantModel get plant => _plant.value;
  set plant(PlantModel newPlant) => _plant.value = newPlant;

  /// Toggles and saves the [isOff] feature.
  void togglePower() {
    _plant.value = _plant.value.copyWith(isOff: !_plant.value.isOff);
  }

  /// Loads the name, species and photo path into the controller and opens the bottom sheet.
  void openEditProfileSheet() {
    nameController.text = _plant.value.name;
    speciesController.text = _plant.value.species;
    _tempPhotoPath.value = _plant.value.photoPath;
    Get.bottomSheet(const MyPlantPageEditProfileSheet());
  }

  /// Save the settings from the [MyPlantPageEditProfileSheet].
  void saveProfile() {
    if (nameController.text.isNotEmpty) {
      _plant.value.name = nameController.text.trim();
    }
    if (speciesController.text.isNotEmpty) {
      _plant.value.species = speciesController.text.trim();
    }

    _plant.value = _plant.value.copyWith(
      name: _plant.value.name,
      species: _plant.value.species,
    );
  }
}
