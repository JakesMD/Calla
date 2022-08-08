import 'package:calla/controllers/app_controller.dart';
import 'package:get/get.dart';

/// A mood given to a plant depending on the conditions of its environment.
enum PlantMood {
  happy,
  cold,
  hot,
  damp,
  dry,
  gloomy,
  blinded,
}

/// A model that represents a plant.
class PlantModel {
  final int number;
  String name;
  String species;
  String photoPath;
  DateTime? lastWatered;
  double preferredLightMin;
  double preferredLightMax;
  double preferredTemperatureMin;
  double preferredTemperatureMax;
  double preferredHumidityMin;
  double preferredHumidityMax;
  double preferredWater;
  bool isOff;

  PlantModel({
    required this.number,
    required this.name,
    required this.species,
    this.lastWatered,
    this.photoPath = '',
    this.preferredHumidityMin = 0.4,
    this.preferredHumidityMax = 0.7,
    this.preferredTemperatureMin = 20,
    this.preferredTemperatureMax = 30,
    this.preferredLightMin = 0.5,
    this.preferredLightMax = 1,
    this.preferredWater = 0.5,
    this.isOff = false,
  });

  /// Calculates [PlantMood]s from the conditions of the environment and returns them in a List.
  List<PlantMood> generateMoods() {
    var moods = <PlantMood>[];

    if (AppCtl.to.humidity < preferredHumidityMin) {
      moods.add(PlantMood.dry);
    } else if (AppCtl.to.humidity > preferredHumidityMax) {
      moods.add(PlantMood.damp);
    }
    if (AppCtl.to.temperature < preferredTemperatureMin) {
      moods.add(PlantMood.cold);
    } else if (AppCtl.to.temperature > preferredTemperatureMax) {
      moods.add(PlantMood.hot);
    }
    if (AppCtl.to.light < preferredLightMin) {
      moods.add(PlantMood.gloomy);
    } else if (AppCtl.to.light > preferredLightMax) {
      moods.add(PlantMood.blinded);
    }
    if (moods.isEmpty) {
      moods.add(PlantMood.happy);
    }
    return moods;
  }

  /// Generates a readable text from calculated moods.
  String generateMoodPhrase() {
    final moods = generateMoods();
    var phrase = "";

    for (int x = 0; x < moods.length; x++) {
      phrase += moods[x].name.tr;
      if (x == moods.length - 2) {
        phrase += " ${"and".tr} ";
      } else if (x != moods.length - 1) {
        phrase += ", ";
      }
    }
    return phrase;
  }
}
