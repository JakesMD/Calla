import 'package:calla/controllers/plant_page_controller.dart';
import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// The bottom sheet that edits a plant's name, species and photo.
class MyPlantPageEditProfileSheet extends StatelessWidget {
  const MyPlantPageEditProfileSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyBottomSheet(
      onSave: PlantPageCtl.to.saveProfile,
      child: MySpacedColumn(
        children: [
          LayoutBuilder(
            builder: (_, constraints) => MyFileImage(
              PlantPageCtl.to.tempPhotoPath,
              height: 100,
              width: constraints.maxWidth,
              borderRadius: BorderRadius.circular(MySizeTheme.borderRadius15),
            ),
          ),
          MyTextField(
            hintText: "Name",
            icon: Icons.title_outlined,
            controller: PlantPageCtl.to.nameController,
          ),
          MyTextField(
            hintText: "Species",
            icon: Icons.grass_outlined,
            controller: PlantPageCtl.to.speciesController,
          ),
        ],
      ),
    );
  }
}
