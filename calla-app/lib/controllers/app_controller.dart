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

  /// The current color theme.
  MyColorTheme get colors => _colors.value;

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
