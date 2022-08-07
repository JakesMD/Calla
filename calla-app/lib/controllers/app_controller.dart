import 'package:flutter/services.dart';
import 'package:get/get.dart';

// TODO: update this comment.

/// The controller that handles things like the color theme.
class AppCtl extends GetxController {
  /// The current instance of [AppCtl].
  static final AppCtl to = Get.find<AppCtl>();

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
