import 'package:calla/controllers/controllers.dart';
import 'package:calla/helpers/range.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

/// The bottom sheet that edits the plant's preferred lighting.
class MyPlantPageEditLightSheet extends StatelessWidget {
  const MyPlantPageEditLightSheet({Key? key}) : super(key: key);

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
                plant.preferredLight.min,
                plant.preferredLight.max,
              ),
              icon: FeatherIcons.sun,
              onChanged: PlantPageCtl.to.editLight,
              range: const Range(0, 1),
              divisions: 20,
              textStart: (plant.preferredLight.min * 100).toInt().toString(),
              textEnd: (plant.preferredLight.max * 100).toInt().toString(),
              textSuffix: "%",
            ),
          ],
        );
      }),
    );
  }
}
