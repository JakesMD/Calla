#include <Arduino.h>
#include <ArduinoJson.h>
#include <BLE2902.h>
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <Preferences.h>

#define DEVICE_NAME "Calla"
#define SERVICE_UUID "20a8f30d-a75c-4475-9f70-49c37b065225"
#define SENSOR_READINGS_CHARACTERISTIC_UUID "850d573b-7d11-4a74-b8c0-05149dbd7256"
#define SETTINGS_CHARACTERISTIC_UUID "5dd76d83-8817-476d-8523-58576ecdc412"

BLEServer *pServer;
BLEService *pService;
BLECharacteristic *pSensorReadingsCharacteristic;
BLECharacteristic *pSettingsCharacteristic;

Preferences prefs;

DynamicJsonDocument data(512);

// Creates the server, service, characteristics and starts advertising.
void setupBLE() {
    Serial.print("\n\nSetting up bluetooth...");

    // Set the device name.
    BLEDevice::init(DEVICE_NAME);

    // Create the BLE server.
    pServer = BLEDevice::createServer();

    // Create the BLE service.
    pService = pServer->createService(SERVICE_UUID);

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

// Loads the saved preferences into data.
void loadPrefs() {
    Serial.print("\n\nLoading preferences...");

    // Open the preferences space in read-only mode.
    prefs.begin("calla");

    // Silent hours:
    data["silentHours"][0] = prefs.getUChar("silentStart");
    data["silentHours"][1] = prefs.getUChar("silentEnd");

    // Water level calibration:
    data["waterLevelCal"][0] = prefs.getUShort("waterLevelMax");
    data["waterLevelCal"][1] = prefs.getUShort("waterLevelMin");

    // Moisture calibration:
    data["plants"][0]["moistureCal"][0] = prefs.getUShort("moisture1Min");
    data["plants"][0]["moistureCal"][1] = prefs.getUShort("moisture1Max");
    data["plants"][1]["moistureCal"][0] = prefs.getUShort("moisture2Min");
    data["plants"][1]["moistureCal"][1] = prefs.getUShort("moisture2Max");
    data["plants"][2]["moistureCal"][0] = prefs.getUShort("moisture3Min");
    data["plants"][2]["moistureCal"][1] = prefs.getUShort("moisture3Max");

    // Watering amount:
    data["plants"][0]["water"] = prefs.getUShort("water1");
    data["plants"][1]["water"] = prefs.getUShort("water2");
    data["plants"][2]["water"] = prefs.getUShort("water3");

    // Watering schedule:
    data["plants"][0]["schedule"] = prefs.getUChar("schedule1");
    data["plants"][1]["schedule"] = prefs.getUChar("schedule2");
    data["plants"][2]["schedule"] = prefs.getUChar("schedule3");

    // Last watered:
    data["plants"][0]["lastWatered"] = prefs.getUChar("lastWatered1");
    data["plants"][1]["lastWatered"] = prefs.getUChar("lastWatered2");
    data["plants"][2]["lastWatered"] = prefs.getUChar("lastWatered3");

    // Is watering scheduled:
    data["plants"][0]["isWateringScheduled"] = data["plants"][0]["schedule"] != 0;
    data["plants"][1]["isWateringScheduled"] = data["plants"][1]["schedule"] != 0;
    data["plants"][2]["isWateringScheduled"] = data["plants"][2]["schedule"] != 0;

    // Is plant of:
    data["plants"][0]["isOff"] = data["plants"][0]["water"] == 0;
    data["plants"][1]["isOff"] = data["plants"][1]["water"] == 0;
    data["plants"][2]["isOff"] = data["plants"][2]["water"] == 0;

    // Close the preferences space.
    prefs.end();
}

// Saves the preferences from data.
void savePrefs() {
    Serial.print("\n\nSaving preferences...");

    // Open the preferences space.
    prefs.begin("calla", false);

    // Silent hours:
    savePrefUChar("silentStart", data["silentHours"][0]);
    savePrefUChar("silentEnd", data["silentHours"][1]);

    // Water level calibration:
    savePrefUShort("waterLevelMin", data["waterLevelCal"][0]);
    savePrefUShort("waterLevelMax", data["waterLevelCal"][1]);

    // Moisture calibration:
    savePrefUShort("moisture1Min", data["plants"][0]["moistureCal"][0]);
    savePrefUShort("moisture1Max", data["plants"][0]["moistureCal"][1]);
    savePrefUShort("moisture2Min", data["plants"][1]["moistureCal"][0]);
    savePrefUShort("moisture2Max", data["plants"][1]["moistureCal"][1]);
    savePrefUShort("moisture3Min", data["plants"][2]["moistureCal"][0]);
    savePrefUShort("moisture3Max", data["plants"][2]["moistureCal"][1]);

    // Watering amount:
    savePrefUShort("water1", data["plants"][0]["isOff"] ? 0 : data["plants"][0]["water"]);
    savePrefUShort("water2", data["plants"][1]["isOff"] ? 0 : data["plants"][1]["water"]);
    savePrefUShort("water3", data["plants"][2]["isOff"] ? 0 : data["plants"][2]["water"]);

    // Watering schedule:
    savePrefUChar("schedule1", data["plants"][0]["isWateringScheduled"] ? data["plants"][0]["schedule"] : 0);
    savePrefUChar("schedule2", data["plants"][1]["isWateringScheduled"] ? data["plants"][1]["schedule"] : 0);
    savePrefUChar("schedule3", data["plants"][2]["isWateringScheduled"] ? data["plants"][2]["schedule"] : 0);

    // Last watered:
    savePrefULong("lastWatered1", data["plants"][0]["lastWatered"]);
    savePrefULong("lastWatered2", data["plants"][1]["lastWatered"]);
    savePrefULong("lastWatered3", data["plants"][2]["lastWatered"]);

    // Close the preferences space.
    prefs.end();
}

void setup() {
    Serial.begin(115200);

    // Load the preferences.
    loadPrefs();

    // Setup the bluetooth.
    setupBLE();
}

void loop() {
    pSensorReadingsCharacteristic->setValue("Hi");
    pSensorReadingsCharacteristic->notify();

    delay(2000);
}