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
    final plant = PlantPageCtl.to.plant;

    return Obx(
      () => MySpacedColumn(
        padding: const EdgeInsets.symmetric(horizontal: MySizeTheme.pageMargin),
        children: [
          MySpacedRow(
            children: [
              // Water:
              Expanded(
                child: MyPlantPagePreferenceBox(
                  color: AppCtl.to.colors.green,
                  icon: FeatherIcons.cloudRain,
                  headline: "WATER",
                  text: plant.wateringSchedule > 0
                      ? "${(plant.preferredWater).toInt()}ml / ${plant.wateringSchedule}h"
                      : "${(plant.preferredWater * 100).toInt()}%",
                ),
              ),
              // Light:
              Expanded(
                child: MyPlantPagePreferenceBox(
                  color: AppCtl.to.colors.orange,
                  icon: FeatherIcons.sun,
                  headline: "LIGHT",
                  text:
                      "${(plant.preferredLightMin * 100).toInt()} - ${(plant.preferredLightMax * 100).toInt()}%",
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
                  headline: "TEMPERATURE",
                  text:
                      "${plant.preferredTemperatureMin.toInt()} - ${plant.preferredTemperatureMax.toInt()}°C",
                ),
              ),
              // Humidity:
              Expanded(
                child: MyPlantPagePreferenceBox(
                  color: AppCtl.to.colors.pink,
                  icon: FeatherIcons.droplet,
                  headline: "HUMIDITY",
                  text:
                      "${(plant.preferredHumidityMin * 100).toInt()} - ${(plant.preferredHumidityMax * 100).toInt()}%",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
