import 'package:calla/controllers/app_controller.dart';
import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A column with [MyHomePagePlant]s.
class MyHomePagePlantSection extends StatelessWidget {
  const MyHomePagePlantSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MySpacedColumn(
        spacing: MySizeTheme.spacing10,
        children: [
          MyHomePagePlant(
            plant: AppCtl.to.plant1,
            isFlipped: true,
            color: AppCtl.to.colors.green,
          ),
          MyHomePagePlant(
            plant: AppCtl.to.plant2,
            color: AppCtl.to.colors.orange,
          ),
          MyHomePagePlant(
            plant: AppCtl.to.plant3,
            isFlipped: true,
            color: AppCtl.to.colors.pink,
          ),
        ],
      ),
    );
  }
}
