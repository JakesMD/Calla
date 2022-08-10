import 'package:calla/controllers/plant_page_controller.dart';
import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

/// The page that represents a plant and controls its preferences.
class PlantPage extends StatelessWidget {
  const PlantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final plant = PlantPageCtl.to.plant;

        return MySpacedColumn(
          spacing: MySizeTheme.spacing25,
          children: [
            Stack(
              children: [
                // Photo:
                MyFileImage(
                  plant.fullPhotoPath(),
                  height: 250,
                  width: Get.width,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(MySizeTheme.borderRadius30),
                    bottomRight: Radius.circular(MySizeTheme.borderRadius30),
                  ),
                ),

                // AppBar:
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(MySizeTheme.pageMargin),
                    child: MyAppBar(
                      leftIcon: FeatherIcons.chevronLeft,
                      onLeftIconTap: Get.back,
                      rightIcon: plant.isOff ? Icons.power_outlined : Icons.power_off_outlined,
                      onRightIconTap: PlantPageCtl.to.togglePower,
                    ),
                  ),
                ),
              ],
            ),
            const MyPlantPageNameSection(),
            const MyPlantPagePreferenceBoxSection(),
          ],
        );
      }),
    );
  }
}
