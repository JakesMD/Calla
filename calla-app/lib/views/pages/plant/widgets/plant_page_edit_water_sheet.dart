import 'package:calla/controllers/app_controller.dart';
import 'package:calla/controllers/plant_page_controller.dart';
import 'package:calla/helpers/range.dart';
import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

/// The bottom sheet that edits the plant's watering system.
class MyPlantPageEditWaterSheet extends StatelessWidget {
  const MyPlantPageEditWaterSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyBottomSheet(
      onSave: PlantPageCtl.to.savePlant,
      child: Obx(() {
        final plant = PlantPageCtl.to.tempPlant;
        return MySpacedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MySpacedRow(
              children: [
                Text(
                  "Auto".tr,
                  style: MyTextTheme.bodyText1,
                ),
                Switch(
                  value: plant.isWateringScheduled,
                  activeTrackColor: AppCtl.to.colors.blue,
                  inactiveTrackColor: AppCtl.to.colors.pink,
                  activeColor: AppCtl.to.colors.background,
                  onChanged: PlantPageCtl.to.editIsWateringScheduled,
                ),
                Text(
                  "Scheduled".tr,
                  style: MyTextTheme.bodyText1,
                ),
              ],
            ),
            MySlider(
              value: plant.isWateringScheduled
                  ? plant.preferredScheduledWater.toDouble()
                  : plant.preferredAutoWater * 100,
              icon: FeatherIcons.cloudDrizzle,
              onChanged: PlantPageCtl.to.editWater,
              divisions: plant.isWateringScheduled ? 50 : 20,
              range: Range(0, plant.isWateringScheduled ? 500 : 100),
              text: plant.isWateringScheduled
                  ? "${plant.preferredScheduledWater}ml"
                  : "${(plant.preferredAutoWater * 100).toInt()}%",
            ),
            MyAnimatedSwitcher(
              child: plant.isWateringScheduled
                  ? MySlider(
                      value: plant.wateringSchedule.toDouble(),
                      icon: FeatherIcons.clock,
                      onChanged: PlantPageCtl.to.editWateringSchedule,
                      range: const Range(0, 168),
                      divisions: 84,
                      text: "${plant.wateringSchedule}h",
                    )
                  : const SizedBox(height: 0),
            ),
          ],
        );
      }),
    );
  }
}
