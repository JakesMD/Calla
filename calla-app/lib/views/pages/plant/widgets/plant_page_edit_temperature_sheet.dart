import 'package:calla/controllers/controllers.dart';
import 'package:calla/helpers/range.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

/// The bottom sheet that edits the plant's preferred temperature.
class MyPlantPageEditTemperatureSheet extends StatelessWidget {
  const MyPlantPageEditTemperatureSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyBottomSheet(
      onSave: PlantPageCtl.to.savePlant,
      child: Obx(() {
        final plant = PlantPageCtl.to.tempPlant;
        return MySpacedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyRangeSlider(
              values: RangeValues(
                plant.preferredTemperature.min,
                plant.preferredTemperature.max,
              ),
              icon: FeatherIcons.thermometer,
              onChanged: PlantPageCtl.to.editTemperature,
              range: const Range(0, 40),
              textStart: (plant.preferredTemperature.min).toInt().toString(),
              textEnd: (plant.preferredTemperature.max).toInt().toString(),
              textSuffix: "°C",
            ),
          ],
        );
      }),
    );
  }
}
