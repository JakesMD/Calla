import 'package:calla/controllers/controllers.dart';
import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

/// A 2x2 grid of [MyPlantPagePreferenceBox]s representing water, light, temperature and humidity.
class MyPlantPagePreferenceBoxSection extends StatelessWidget {
  const MyPlantPagePreferenceBoxSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final plant = PlantPageCtl.to.plant;

      return MySpacedColumn(
        padding: const EdgeInsets.symmetric(horizontal: MySizeTheme.pageMargin),
        children: [
          MySpacedRow(
            children: [
              // Water:
              Expanded(
                child: MyPlantPagePreferenceBox(
                  color: AppCtl.to.colors.green,
                  icon: FeatherIcons.cloudDrizzle,
                  headline: "WATER".tr,
                  text: plant.isWateringScheduled
                      ? "${plant.preferredScheduledWater}ml"
                      : "${(plant.preferredAutoWater * 100).toInt()}%",
                  suffixText: plant.isWateringScheduled ? "/ ${plant.wateringSchedule}h" : "",
                  onTap: PlantPageCtl.to.showEditWaterSheet,
                ),
              ),

              // Light:
              Expanded(
                child: MyPlantPagePreferenceBox(
                  color: AppCtl.to.colors.orange,
                  icon: FeatherIcons.sun,
                  headline: "LIGHT".tr,
                  text:
                      "${(plant.preferredLight.min * 100).toInt()} - ${(plant.preferredLight.max * 100).toInt()}%",
                  onTap: PlantPageCtl.to.showEditLightSheet,
                ),
              ),
            ],
          ),
          MySpacedRow(
            children: [
              // Temperature:
              Expanded(
                child: MyPlantPagePreferenceBox(
                  color: AppCtl.to.colors.purple,
                  icon: FeatherIcons.thermometer,
                  headline: "TEMPERATURE".tr,
                  text:
                      "${(plant.preferredTemperature.min).toInt()} - ${(plant.preferredTemperature.max).toInt()}°C",
                  onTap: PlantPageCtl.to.showEditTemperatureSheet,
                ),
              ),
              // Humidity:
              Expanded(
                child: MyPlantPagePreferenceBox(
                  color: AppCtl.to.colors.pink,
                  icon: FeatherIcons.droplet,
                  headline: "HUMIDITY".tr,
                  text:
                      "${(plant.preferredHumidity.min * 100).toInt()} - ${(plant.preferredHumidity.max * 100).toInt()}%",
                  onTap: PlantPageCtl.to.showEditHumiditySheet,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
