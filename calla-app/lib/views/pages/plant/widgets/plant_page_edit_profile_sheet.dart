import 'package:calla/controllers/plant_page_controller.dart';
import 'package:calla/services/file_service.dart';
import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

/// The bottom sheet that edits the plant's name, species and photo.
class MyPlantPageEditProfileSheet extends StatelessWidget {
  const MyPlantPageEditProfileSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyBottomSheet(
      onSave: () => PlantPageCtl.to.savePlant(savePhoto: true),
      child: MySpacedColumn(
        children: [
          SizedBox(
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Obx(
                    () => MyFileImage(
                      FileSvc.to.tempImagePath,
                      opacity: 0.5,
                      borderRadius: BorderRadius.circular(MySizeTheme.borderRadius15),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyCircularIconButton(
                        FeatherIcons.camera,
                        onTap: () => FileSvc.to.pickTempImage(ImageSource.camera),
                      ),
                      MyCircularIconButton(
                        Icons.photo_library_outlined,
                        onTap: () => FileSvc.to.pickTempImage(ImageSource.gallery),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          MyTextField(
            hintText: "Name".tr,
            icon: Icons.title_outlined,
            controller: PlantPageCtl.to.nameController,
          ),
          MyTextField(
            hintText: "Species".tr,
            icon: Icons.grass_outlined,
            controller: PlantPageCtl.to.speciesController,
          ),
        ],
      ),
    );
  }
}
