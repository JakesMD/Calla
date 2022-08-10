import 'package:calla/controllers/controllers.dart';
import 'package:calla/helpers/range.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

/// The bottom sheet that edits the plant's preferred humidity.
class MyPlantPageEditHumiditySheet extends StatelessWidget {
  const MyPlantPageEditHumiditySheet({Key? key}) : super(key: key);

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
                plant.preferredHumidity.min,
                plant.preferredHumidity.max,
              ),
              icon: FeatherIcons.droplet,
              onChanged: PlantPageCtl.to.editHumidity,
              range: const Range(0, 1),
              divisions: 20,
              textStart: (plant.preferredHumidity.min * 100).toInt().toString(),
              textEnd: (plant.preferredHumidity.max * 100).toInt().toString(),
              textSuffix: "%",
            ),
          ],
        );
      }),
    );
  }
}
