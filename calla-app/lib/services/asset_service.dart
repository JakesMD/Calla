import 'package:calla/constants/constants.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// The service that preloads and stores all the assets.
class AssetSvc extends GetxService {
  /// The current instance of [AuthSvc].
  static final AssetSvc to = Get.find<AssetSvc>();

  /// A Map of the illustrations with their source code;
  Map<Illustrations, String> illustrations = {};

  /// Initializes the [AssetSvc] and returns an instance of it.
  Future<AssetSvc> init() async {
    // Load the illustrations.
    await _loadIllustrations();
    return this;
  }

  /// Loads the illustration assets into [illustrations].
  Future<void> _loadIllustrations() async {
    for (var illustration in Illustrations.values) {
      var code =
          await loadString("assets/illustrations/${illustration.name}.svg") ??
              "";
      illustrations.addAll({illustration: code});
    }
  }

  /// Loads an asset as a String (loads the source code).
  Future<String?> loadString(String path) async {
    try {
      return await rootBundle.loadString(path);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
