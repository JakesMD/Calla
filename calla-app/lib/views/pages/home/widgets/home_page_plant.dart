import 'package:calla/controllers/app_controller.dart';
import 'package:calla/models/plant_model.dart';
import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

/// A representation of a plant.
class MyHomePagePlant extends StatelessWidget {
  final PlantModel plant;
  final Color color;

  /// The design has [MyHomePagePlant]s where the image and plant are flipped alternatingly.
  final bool isFlipped;

  const MyHomePagePlant({
    Key? key,
    required this.plant,
    required this.color,
    this.isFlipped = false,
  }) : super(key: key);

  /// Generates a border radius based on which side the curve is on and whether it is the inside or outside of the border.
  ///
  /// See [_borderedContainer].
  BorderRadius _generateBorderRadius({required bool isInside, required bool curveOnLeft}) {
    final radius = MySizeTheme.borderRadius15 + (isInside ? 0 : MySizeTheme.borderWidth25);

    return BorderRadius.only(
      topLeft: Radius.circular(curveOnLeft ? radius : 0),
      bottomLeft: Radius.circular(curveOnLeft ? radius : 0),
      topRight: Radius.circular(!curveOnLeft ? radius : 0),
      bottomRight: Radius.circular(!curveOnLeft ? radius : 0),
    );
  }

  /// A [Container] in a second [Container] that acts as a border.
  ///
  /// This is necessary because you can't have a varied border as well as a border radius in Flutter.
  /// To get round this we put a container inside another with some padding between them.
  Container _borderedContainer({
    required Widget child,
    required bool curveOnLeft,
    Color? color,
    EdgeInsets? padding,
    double? width,
  }) {
    return Container(
      width: width,
      padding: EdgeInsets.fromLTRB(curveOnLeft ? MySizeTheme.borderWidth25 : 0,
          MySizeTheme.borderWidth25, !curveOnLeft ? 2 : 0, MySizeTheme.borderWidth25),
      decoration: BoxDecoration(
        color: AppCtl.to.colors.background,
        borderRadius: _generateBorderRadius(isInside: false, curveOnLeft: curveOnLeft),
      ),
      child: Container(
        height: 125,
        padding: padding,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: color,
          borderRadius: _generateBorderRadius(isInside: true, curveOnLeft: curveOnLeft),
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // We define the children here in case we need to reverse the order.
    final children = <Widget>[
      // Image:
      _borderedContainer(
        curveOnLeft: isFlipped,
        width: 100,
        child: MyFileImage(plant.fullPhotoPath()),
      ),

      // Plant:
      Expanded(
        child: _borderedContainer(
          curveOnLeft: !isFlipped,
          color: color,
          padding: const EdgeInsets.all(MySizeTheme.spacing15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name and emoji:
              MySpacedRow(
                children: [
                  Expanded(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: plant.name,
                        style: MyTextTheme.headline2,
                        children: [
                          TextSpan(
                            text: plant.isOff
                                ? " ${"is off".tr}"
                                : " ${"is ${plant.generateMoodPhrase()}".tr}",
                            style: MyTextTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  MyIcon(
                    plant.isOff
                        ? Icons.power_off_outlined
                        : plant.generateMoods().contains(PlantMood.happy)
                            ? FeatherIcons.smile
                            : FeatherIcons.frown,
                  ),
                ],
              ),

              // Species:
              Text(
                plant.species,
                style: MyTextTheme.bodyText1,
              ),

              const Spacer(),

              // Last watered text and arrow icon:
              MySpacedRow(
                children: [
                  Expanded(
                    child: !plant.isOff && plant.lastWatered != null
                        ? Text(
                            "${"last watered".tr}: ${DateFormat.MMMd().format(plant.lastWatered!)}, ${DateFormat.Hm().format(plant.lastWatered!)}",
                            style: MyTextTheme.bodyText2,
                            textAlign: TextAlign.end,
                          )
                        : Container(),
                  ),
                  MyIcon(
                    FeatherIcons.arrowRight,
                    onTap: () => AppCtl.to.goToPlantPage(plant.number),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ];

    return MySpacedRow(
      spacing: MySizeTheme.spacing15,
      // Reverse the children if flipped.
      children: isFlipped ? children.reversed.toList() : children,
    );
  }
}
