import 'package:calla/controllers/app_controller.dart';
import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The page that displays the current sensor readings and the plants' moods.
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            const Positioned(
              bottom: 0,
              child: MyHomePageWaterLevelIndicator(),
            ),
            Positioned.fill(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: MySizeTheme.pageMargin),
                physics: const BouncingScrollPhysics(),
                child: MySpacedColumn(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: MySizeTheme.spacing35,
                  children: [
                    const MyHomePageAppBar(),
                    const MyHomePageSensorReadingSection(),
                    Obx(() => Text(
                          "${(AppCtl.to.waterLevel * 100).toInt()}% ${"full".tr} - ${AppCtl.to.waterLevel > 0 ? "Ready to go!".tr : "Please refill.".tr}",
                          style: MyTextTheme.headline3,
                          textAlign: TextAlign.center,
                        )),
                    const MyHomePagePlantSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
