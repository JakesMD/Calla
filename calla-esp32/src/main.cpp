// Include the libraries.
#include <Adafruit_NeoPixel.h>
#include <Adafruit_Sensor.h>
#include <Arduino.h>
#include <ArduinoJson.h>
#include <BLE2902.h>
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <DHT.h>
#include <Preferences.h>

// TODO: Edit the pins.

// Define the pins.
#define SENSOR_POWER_PIN 13
#define LIGHT_SENSOR_PIN 36
#define MOISTURE_SENSOR_1_PIN 39
#define MOISTURE_SENSOR_2_PIN 34
#define MOISTURE_SENSOR_3_PIN 35
#define DHT_PIN 5
#define PUMP_1_PIN 15
#define PUMP_2_PIN 2
#define PUMP_3_PIN 4
#define NEOPIXEL_PIN 18

// Define the bluetooth settings.
#define DEVICE_NAME "Calla"
#define SERVICE_UUID "20a8f30d-a75c-4475-9f70-49c37b065225"
#define SENSOR_READINGS_CHARACTERISTIC_UUID "850d573b-7d11-4a74-b8c0-05149dbd7256"
#define SETTINGS_CHARACTERISTIC_UUID "5dd76d83-8817-476d-8523-58576ecdc412"

// Define the bluetooth server, service and characteristics.
BLEServer *pServer;
BLEService *pService;
BLECharacteristic *pSensorReadingsCharacteristic;
BLECharacteristic *pSettingsCharacteristic;

// Define the preferences, settings json and sensor readings json.
Preferences prefs;
DynamicJsonDocument settings(256);
DynamicJsonDocument sensorReadings(256);

// Define the DHT sensor and NeoPixel strip.
DHT dht(DHT_PIN, DHT11);
Adafruit_NeoPixel strip = Adafruit_NeoPixel(8, NEOPIXEL_PIN, NEO_GRB + NEO_KHZ800);

// Define the sensor readings.
float humidity = 0;
float temperature = 0;
uint16_t light = 0;
uint16_t moisture1 = 0;
uint16_t moisture2 = 0;
uint16_t moisture3 = 0;

// Sets the pin modes for the sensors pins.
void setupSensors() {
    Serial.print("\n\nSetting up the sensors");

    // Analog inputs:
    pinMode(LIGHT_SENSOR_PIN, INPUT);
    pinMode(MOISTURE_SENSOR_1_PIN, INPUT);
    pinMode(MOISTURE_SENSOR_2_PIN, INPUT);
    pinMode(MOISTURE_SENSOR_3_PIN, INPUT);

    // Digital outputs:
    pinMode(PUMP_1_PIN, OUTPUT);
    pinMode(PUMP_2_PIN, OUTPUT);
    pinMode(PUMP_3_PIN, OUTPUT);

    // Make sure the pumps are off.
    digitalWrite(PUMP_1_PIN, LOW);
    digitalWrite(PUMP_2_PIN, LOW);
    digitalWrite(PUMP_3_PIN, LOW);
}

// Takes multiple readings over some time and returns the average.
float takeAverageReading(const int pin) {
    const int amount = 10;  // The amount of reading to take.
    float readingsSum = 0;  // The sum of all the readings.
    int reading = 0;

    Serial.print(F(" ("));
    digitalWrite(SENSOR_POWER_PIN, HIGH);  // Turn the sensor on.

    for (int x = 0; x < amount; x++) {
        delay(1000);  // Wait a little before taking the next reading.

        // Take the reading and add it to the sum.
        reading = analogRead(pin);

        // Print the reading.
        Serial.print(F(" "));
        Serial.print(reading);
    }

    digitalWrite(SENSOR_POWER_PIN, LOW);  // Turn the sensor off.
    Serial.print(F(" )"));

    return readingsSum / amount;  // Return the average.
}

// Prints a sensor reading in a nice way.
void printReading(const char *text, const uint16_t reading, const int percentage) {
    Serial.print(F("\n"));
    Serial.print(F(text));
    Serial.print(F(": "));
    Serial.print(reading);
    Serial.print(F(" = "));
    Serial.print(percentage);
    Serial.print(F("%"));
}

// Reads the DHT11 sensor.
void readDHT() {
    Serial.print(F("\n\nReading DHT sensor..."));

    // Turn the DHT on and give it some time to initialize.
    digitalWrite(SENSOR_POWER_PIN, HIGH);
    delay(50);
    dht.begin();
    delay(1000);

    // Read the temperature and humidity.
    float t = dht.readTemperature();
    float h = dht.readHumidity();

    digitalWrite(SENSOR_POWER_PIN, LOW);  // Turn the DHT off.

    // Check if the reading failed.
    if (isnan(h) || isnan(t)) {
        Serial.println(F(" failed."));
        return;
    }

    // Update the temperature and humidity.
    temperature = t;
    humidity = h;

    // Print the result.
    Serial.print(F("\nHumidity: "));
    Serial.print(humidity);
    Serial.print(F("%  Temperature: "));
    Serial.print(temperature);
    Serial.print(F("°C "));
}

// Reads the light sensor.
void readLightSensor() {
    Serial.print(F("\n\nReading light sensor..."));

    float reading = takeAverageReading(LIGHT_SENSOR_PIN);                            // Read the sensor.
    light = map(reading, settings["lightCalMin"], settings["lightCalMax"], 0, 100);  // Update the light as percentage.

    printReading("Light", reading, light);  // Print the reading.
}

// Reads the moisture sensors.
void readMoistureSensors() {
    Serial.print(F("\n\nReading moisture sensors..."));

    // Read the sensors.
    float reading1 = takeAverageReading(MOISTURE_SENSOR_1_PIN);
    float reading2 = takeAverageReading(MOISTURE_SENSOR_2_PIN);
    float reading3 = takeAverageReading(MOISTURE_SENSOR_3_PIN);

    // Update the moistures as a percentage.
    moisture1 = map(reading1, settings["soil1CalMin"], settings["soil1CalMax"], 0, 100);
    moisture2 = map(reading2, settings["soil2CalMin"], settings["soil2CalMax"], 0, 100);
    moisture3 = map(reading3, settings["soil3CalMin"], settings["soil3CalMax"], 0, 100);

    // Print the readings.
    printReading("Moisture 1", reading1, moisture1);
    printReading("Moisture 2", reading2, moisture2);
    printReading("Moisture 3", reading3, moisture3);
}

// Creates the server, service, characteristics and starts advertising.
void setupBLE() {
    Serial.print("\n\nSetting up bluetooth...");

    BLEDevice::init(DEVICE_NAME);                     // Set the device name.
    pServer = BLEDevice::createServer();              // Create the BLE server.
    pService = pServer->createService(SERVICE_UUID);  // Create the BLE service.

    // Create the characteristics.
    pSensorReadingsCharacteristic = pService->createCharacteristic(
        SENSOR_READINGS_CHARACTERISTIC_UUID,
        BLECharacteristic::PROPERTY_NOTIFY);
    pSettingsCharacteristic = pService->createCharacteristic(
        SETTINGS_CHARACTERISTIC_UUID,
        BLECharacteristic::PROPERTY_READ | BLECharacteristic::PROPERTY_WRITE);

    pSensorReadingsCharacteristic->addDescriptor(new BLE2902());

    // Start the service.
    Serial.print("\nStarting bluetooth service...");
    pService->start();

    // Start advertising.
    Serial.print("\nStarting advertising...");
    BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
    pAdvertising->addServiceUUID(SERVICE_UUID);
    pAdvertising->setScanResponse(true);
    pAdvertising->setMinPreferred(0x06);  // functions that help with iPhone connections issue
    pAdvertising->setMinPreferred(0x12);
    BLEDevice::startAdvertising();
}

// Checks that the value has changed before saving.
void savePrefUChar(const char *key, uint8_t value) {
    if (prefs.getUChar(key) != value) {
        prefs.putUChar(key, value);
    }
}

// Checks that the value has changed before saving.
void savePrefUShort(const char *key, uint16_t value) {
    if (prefs.getUShort(key) != value) {
        prefs.putUShort(key, value);
    }
}

// Checks that the value has changed before saving.
void savePrefULong(const char *key, uint32_t value) {
    if (prefs.getULong(key) != value) {
        prefs.putULong(key, value);
    }
}

// Loads the saved preferences into settings.
void loadPrefs() {
    Serial.print("\n\nLoading preferences...");

    prefs.begin("calla");  // Open the preferences space in read-only mode.

    // Silent hours:
    settings["silenceStart"] = prefs.getUChar("silenceStart", 0);
    settings["silenceEnd"] = prefs.getUChar("silenceEnd", 0);

    // Water level calibration:
    settings["waterCalMin"] = prefs.getUShort("waterCalMin", 0);
    settings["waterCalMax"] = prefs.getUShort("waterCalMax", 1000);

    // Light calibration:
    settings["lightCalMin"] = prefs.getUShort("lightCalMin", 800);
    settings["lightCalMax"] = prefs.getUShort("lightCalMax", 4095);

    // Moisture calibration:
    settings["soil1CalMin"] = prefs.getUShort("soil1CalMin", 4095);
    settings["soil1CalMax"] = prefs.getUShort("soil1CalMax", 0);
    settings["soil2CalMin"] = prefs.getUShort("soil2CalMin", 4095);
    settings["soil2CalMax"] = prefs.getUShort("soil2CalMax", 0);
    settings["soil3CalMin"] = prefs.getUShort("soil3CalMin", 4095);
    settings["soil3CalMax"] = prefs.getUShort("soil3CalMax", 0);

    // Watering amount:
    settings["water1"] = prefs.getUShort("water1", 50);
    settings["water2"] = prefs.getUShort("water2", 50);
    settings["water3"] = prefs.getUShort("water3", 50);

    // Watering schedule:
    settings["schedule1"] = prefs.getUChar("schedule1", 8);
    settings["schedule2"] = prefs.getUChar("schedule2", 8);
    settings["schedule3"] = prefs.getUChar("schedule3", 8);

    // Last watered:
    settings["lastWatered1"] = prefs.getULong("lastWatered1", 0);
    settings["lastWatered2"] = prefs.getULong("lastWatered2", 0);
    settings["lastWatered3"] = prefs.getULong("lastWatered3", 0);

    prefs.end();  // Close the preferences space.
}

// Saves the preferences from settings.
void savePrefs() {
    Serial.print("\n\nSaving preferences...");

    prefs.begin("calla", false);  // Open the preferences space.

    // Silent hours:
    savePrefUChar("silenceStart", settings["silenceStart"]);
    savePrefUChar("silenceEnd", settings["silenceEnd"]);

    // Water level calibration:
    savePrefUShort("waterCalMin", settings["waterCalCal"]);
    savePrefUShort("waterCalMax", settings["waterCalCal"]);

    // Moisture calibration:
    savePrefUShort("soil1CalMin", settings["soil1CalMin"]);
    savePrefUShort("soil1CalMax", settings["soil1CalMax"]);
    savePrefUShort("soil2CalMin", settings["soil2CalMin"]);
    savePrefUShort("soil2CalMax", settings["soil2CalMax"]);
    savePrefUShort("soil3CalMin", settings["soil3CalMin"]);
    savePrefUShort("soil3CalMax", settings["soil3CalMax"]);

    // Watering amount:
    savePrefUShort("water1", settings["water1"]);
    savePrefUShort("water2", settings["water2"]);
    savePrefUShort("water3", settings["water3"]);

    // Watering schedule:
    savePrefUChar("schedule1", settings["schedule1"]);
    savePrefUChar("schedule2", settings["schedule2"]);
    savePrefUChar("schedule3", settings["schedule3"]);

    // Last watered:
    savePrefULong("lastWatered1", settings["lastWatered1"]);
    savePrefULong("lastWatered2", settings["lastWatered2"]);
    savePrefULong("lastWatered3", settings["lastWatered3"]);

    prefs.end();  // Close the preferences space.
}

void setup() {
    Serial.begin(115200);

    setupSensors();  // Setup the sensors.
    loadPrefs();     // Load the preferences.
    setupBLE();      // Setup the bluetooth.
}

void loop() {
    // pSensorReadingsCharacteristic->setValue();
    // pSensorReadingsCharacteristic->notify();

    delay(2000);
}