/// A model that represents a plant.
class PlantModel {
  final int number;
  String name;
  String species;
  String photoPath;
  DateTime? lastWatered;
  int preferredLightMin;
  int preferredLightMax;
  int preferredTemperatureMin;
  int preferredTemperatureMax;
  int preferredHumidityMin;
  int preferredHumidityMax;
  int preferredWater;
  bool isOff;

  PlantModel({
    required this.number,
    required this.name,
    required this.species,
    this.lastWatered,
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
