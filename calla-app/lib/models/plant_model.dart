/// A model that represents a plant.
class PlantModel {
  final int number;
  final String name;
  final String type;
  final String photoPath;
  final DateTime lastWatered;
  final int preferredLightMin;
  final int preferredLightMax;
  final int preferredTemperatureMin;
  final int preferredTemperatureMax;
  final int preferredHumidityMin;
  final int preferredHumidityMax;
  final int preferredWater;
  final bool isOff;

  PlantModel({
    required this.number,
    required this.name,
    required this.type,
    required this.lastWatered,
    this.photoPath = '',
    this.preferredHumidityMin = 40,
    this.preferredHumidityMax = 70,
    this.preferredTemperatureMin = 20,
    this.preferredTemperatureMax = 30,
    this.preferredLightMin = 50,
    this.preferredLightMax = 100,
    this.preferredWater = 50,
    this.isOff = false,
  });

  String generateMood() => "happy";
}
