#include <Arduino.h>
#include <ArduinoJson.h>
#include <BLE2902.h>
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>

#define SERVICE_UUID "20a8f30d-a75c-4475-9f70-49c37b065225"
#define SENSOR_READINGS_CHARACTERISTIC_UUID "850d573b-7d11-4a74-b8c0-05149dbd7256"
#define SETTINGS_CHARACTERISTIC_UUID "5dd76d83-8817-476d-8523-58576ecdc412"

BLEServer *pServer;
BLEService *pService;
BLECharacteristic *pSensorReadingsCharacteristic;
BLECharacteristic *pSettingsCharacteristic;

int x = 0;

void setupBLE() {
    // Set the device name.
    BLEDevice::init("Calla");

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
    pService->start();

    // Start advertising.
    BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
    pAdvertising->addServiceUUID(SERVICE_UUID);
    pAdvertising->setScanResponse(true);
    pAdvertising->setMinPreferred(0x06);  // functions that help with iPhone connections issue
    pAdvertising->setMinPreferred(0x12);
    BLEDevice::startAdvertising();

    // pCharacteristic->setValue("Hello World says Neil");
}

void setup() {
    Serial.begin(115200);

    // Setup the bluetooth.
    setupBLE();
}

void loop() {
    pSensorReadingsCharacteristic->setValue(x);
    pSensorReadingsCharacteristic->notify();

    x++;

    if (x > 200) {
        x = 0;
    }

    delay(2000);
}