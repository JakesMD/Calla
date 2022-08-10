import 'package:calla/models/plant_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// The service that handles all the settings saved in local storage.
class PrefsSvc extends GetxService {
  /// The current instance of [FileSvc].
  static final PrefsSvc to = Get.find<PrefsSvc>();

  /// The local storage bucket.
  final _box = GetStorage();

  /// Plant1 saved in local storage.
  late PlantModel plant1;

  /// Plant2 saved in local storage.
  late PlantModel plant2;

  /// Plant3 saved in local storage.
  late PlantModel plant3;

  /// Initializes the [PrefsSvc] and returns an instance of it.
  Future<PrefsSvc> init() async {
    // Initialize and load the storage.
    await GetStorage.init();

    // Load the plants from the storage.
    plant1 = PlantModel.fromJson(_box.read("plant1") ?? {'number': 1});
    plant2 = PlantModel.fromJson(_box.read("plant2") ?? {'number': 2});
    plant3 = PlantModel.fromJson(_box.read("plant3") ?? {'number': 3});

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
