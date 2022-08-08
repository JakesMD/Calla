import 'package:calla/models/plant_model.dart';
import 'package:get/get.dart';

/// The controller that controls the [PlantPage].
class PlantPageCtl extends GetxController {
  /// The current instance of [PlantPageCtl].
  static final PlantPageCtl to = Get.find<PlantPageCtl>();

  final Rx<PlantModel> _plant = PlantModel(
    number: 0,
    name: "",
    species: "",
  ).obs;

  PlantModel get plant => _plant.value;
  set plant(PlantModel newPlant) => _plant.value = newPlant;
}
