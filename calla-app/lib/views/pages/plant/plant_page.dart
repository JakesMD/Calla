import 'package:calla/controllers/plant_page_controller.dart';
import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlantPage extends StatelessWidget {
  const PlantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => MySpacedColumn(
          children: [
            Stack(
              children: [
                MyFileImage(
                  PlantPageCtl.to.plant.photoPath,
                  height: 250,
                  width: Get.width,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(MySizeTheme.borderRadius30),
                    bottomRight: Radius.circular(MySizeTheme.borderRadius30),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(MySizeTheme.pageMargin),
                    child: MyAppBar(
                      leftIcon: CupertinoIcons.left_chevron,
                      onLeftIconTap: Get.back,
                      rightIcon: PlantPageCtl.to.plant.isOff
                          ? Icons.power_outlined
                          : Icons.power_off_outlined,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
