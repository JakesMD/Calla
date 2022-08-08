import 'package:calla/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

/// A [LiquidProgressIndicator] representing the current water level.
class MyHomePageWaterLevelIndicator extends StatelessWidget {
  const MyHomePageWaterLevelIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height / 1.7,
      child: Obx(
        () => LiquidLinearProgressIndicator(
          value: AppCtl.to.waterLevel - (AppCtl.to.waterLevel > 0.05 ? 0.05 : 0),
          direction: Axis.vertical,
          amplitude: 5,
          valueColor: AlwaysStoppedAnimation(AppCtl.to.colors.blue),
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0,
        ),
      ),
    );
  }
}
