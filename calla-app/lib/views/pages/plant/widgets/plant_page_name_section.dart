import 'package:calla/controllers/plant_page_controller.dart';
import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

/// The name and species of a plant alongside an edit icon.
class MyPlantPageNameSection extends StatelessWidget {
  const MyPlantPageNameSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final plant = PlantPageCtl.to.plant;

      return MySpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        padding: const EdgeInsets.symmetric(horizontal: MySizeTheme.pageMargin),
        spacing: 0,
        children: [
          MySpacedRow(
            children: [
              Expanded(
                child: Text(
                  plant.name,
                  style: MyTextTheme.headline1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              MyIcon(
                FeatherIcons.edit2,
                onTap: PlantPageCtl.to.showEditProfileSheet,
              ),
            ],
          ),
          Text(
            plant.species,
            style: MyTextTheme.headline3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    });
  }
}
