import 'package:calla/controllers/app_controller.dart';
import 'package:calla/helpers/range.dart';
import 'package:calla/services/file_service.dart';
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
  Range preferredLight;
  Range preferredTemperature;
  Range preferredHumidity;
  int preferredScheduledWater;
  double preferredAutoWater;
  int wateringSchedule;
  bool isWateringScheduled;
  bool isOff;

  PlantModel({
    required this.number,
    this.name = "Plant",
    this.species = "",
    this.photoPath = "",
    this.lastWatered,
    this.preferredLight = const Range(0.5, 1),
    this.preferredTemperature = const Range(15, 25),
    this.preferredHumidity = const Range(0.45, 0.75),
    this.preferredScheduledWater = 24,
    this.preferredAutoWater = 0.5,
    this.wateringSchedule = 24,
    this.isWateringScheduled = false,
    this.isOff = true,
  });

  /// Fetches the location of the photo in the app documents directory.
  String fullPhotoPath() => photoPath.isNotEmpty ? "${FileSvc.to.documentsDirPath}/$photoPath" : "";

  /// Calculates [PlantMood]s from the conditions of the environment and returns them in a List.
  List<PlantMood> generateMoods() {
    var moods = <PlantMood>[];

    if (AppCtl.to.humidity < preferredHumidity.min) {
      moods.add(PlantMood.dry);
    } else if (AppCtl.to.humidity > preferredHumidity.max) {
      moods.add(PlantMood.damp);
    }
    if (AppCtl.to.temperature < preferredTemperature.min) {
      moods.add(PlantMood.cold);
    } else if (AppCtl.to.temperature > preferredTemperature.max) {
      moods.add(PlantMood.hot);
    }
    if (AppCtl.to.light < preferredLight.min) {
      moods.add(PlantMood.gloomy);
    } else if (AppCtl.to.light > preferredLight.max) {
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

  PlantModel.fromJson(Map<String, dynamic> json)
      : number = json['number'],
        name = json['name'] ?? "Plant${json['number']}",
        species = json['species'] ?? "",
        photoPath = json['photoPath'] ?? "",
        lastWatered = null,
        preferredLight = Range(
          json['preferredLight'] != null ? json['preferredLight'][0] : 0.5,
          json['preferredLight'] != null ? json['preferredLight'][1] : 1,
        ),
        preferredTemperature = Range(
          json['preferredTemperature'] != null ? json['preferredTemperature'][0] : 15,
          json['preferredTemperature'] != null ? json['preferredTemperature'][1] : 25,
        ),
        preferredHumidity = Range(
          json['preferredHumidity'] != null ? json['preferredHumidity'][0] : 0.45,
          json['preferredHumidity'] != null ? json['preferredHumidity'][1] : 0.75,
        ),
        preferredAutoWater = json['preferredAutoWater'] ?? 0.5,
        preferredScheduledWater = json['preferredScheduledWater'] ?? 24,
        wateringSchedule = json['wateringSchedule'] ?? 0,
        isWateringScheduled = json['isWateringScheduled'] ?? false,
        isOff = json['isOff'] ?? true;

  Map<String, dynamic> toJson() => {
        'number': number,
        'name': name,
        'species': species,
        'photoPath': photoPath,
        'preferredLight': [preferredLight.min, preferredLight.max],
        'preferredTemperature': [preferredTemperature.min, preferredTemperature.max],
        'preferredHumidity': [preferredHumidity.min, preferredHumidity.max],
        'preferredAutoWater': preferredAutoWater,
        'preferredScheduledWater': preferredScheduledWater,
        'wateringSchedule': wateringSchedule,
        'isWateringScheduled': isWateringScheduled,
        'isOff': isOff,
      };

  PlantModel copyWith({
    String? name,
    String? species,
    String? photoPath,
    DateTime? lastWatered,
    Range? preferredLight,
    Range? preferredTemperature,
    Range? preferredHumidity,
    double? preferredAutoWater,
    int? preferredScheduledWater,
    int? wateringSchedule,
    bool? isWateringScheduled,
    bool? isOff,
  }) {
    return PlantModel(
      number: number,
      name: name ?? this.name,
      species: species ?? this.species,
      photoPath: photoPath ?? this.photoPath,
      lastWatered: lastWatered ?? this.lastWatered,
      preferredLight: preferredLight ?? this.preferredLight,
      preferredTemperature: preferredTemperature ?? this.preferredTemperature,
      preferredHumidity: preferredHumidity ?? this.preferredHumidity,
      preferredAutoWater: preferredAutoWater ?? this.preferredAutoWater,
      preferredScheduledWater: preferredScheduledWater ?? this.preferredScheduledWater,
      wateringSchedule: wateringSchedule ?? this.wateringSchedule,
      isWateringScheduled: isWateringScheduled ?? this.isWateringScheduled,
      isOff: isOff ?? this.isOff,
    );
  }
}
