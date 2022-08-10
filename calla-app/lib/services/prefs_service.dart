import 'package:calla/controllers/app_controller.dart';
import 'package:calla/models/plant_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// The service that handles all the settings saved in local storage.
class PrefsSvc extends GetxService {
  /// The current instance of [FileSvc].
  static final PrefsSvc to = Get.find<PrefsSvc>();

  /// The local storage bucket.
  final _box = GetStorage();

  /// Initializes the [PrefsSvc] and returns an instance of it.
  Future<PrefsSvc> init() async {
    // Initialize and load the storage.
    await GetStorage.init();

    // Load the plants from the storage into the app controller.
    AppCtl.to.loadPlants([
      PlantModel.fromJson(_box.read("plant1") ?? {'number': 1}),
      PlantModel.fromJson(_box.read("plant2") ?? {'number': 2}),
      PlantModel.fromJson(_box.read("plant3") ?? {'number': 3}),
    ]);

    return this;
  }

  // Saves the the given plant to the storage.
  Future<bool> savePlant(PlantModel plant) async {
    try {
      await _box.write("plant${plant.number}", plant.toJson());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
