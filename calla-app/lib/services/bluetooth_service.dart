import 'dart:async';
import 'dart:convert';
import 'package:calla/controllers/app_controller.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

/// The service that handles all the bluetooth connectivity and serial.
class BluetoothSvc extends GetxService {
  /// The current instance of [BluetoothSvc].
  static final BluetoothSvc to = Get.find<BluetoothSvc>();

  final String _targetDeviceName = "Calla";
  final String _serviceUuid = "20a8f30d-a75c-4475-9f70-49c37b065225";
  final String _readingsCharacteristicUuid = "850d573b-7d11-4a74-b8c0-05149dbd7256";
  final String _settingsCharacteristicUuid = "5dd76d83-8817-476d-8523-58576ecdc412";

  /// The current instance of [FlutterBlue].
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  StreamSubscription<ScanResult>? _scanSubScription;
  BluetoothDevice? _targetDevice;
  BluetoothCharacteristic? _readingsCharacteristic;
  BluetoothCharacteristic? _settingsCharacteristic;

  /// Initializes the [BluetoothSvc] and returns an instance of it.
  Future<BluetoothSvc> init() async {
    startScan();
    return this;
  }

  void startScan() {
    _scanSubScription = flutterBlue.scan().listen((scanResult) {
      if (scanResult.device.name == _targetDeviceName) {
        stopScan();
        print("Device found");
        _targetDevice = scanResult.device;
        connectToDevice();
        print("Device connected");
        discoverServices();
      }
    }, onDone: () => stopScan());
  }

  void stopScan() {
    _scanSubScription?.cancel();
    _scanSubScription = null;
  }

  void connectToDevice() async {
    if (_targetDevice == null) return;
    await _targetDevice!.connect();
  }

  void discoverServices() async {
    if (_targetDevice == null) return;

    List<BluetoothService> services = await _targetDevice!.discoverServices();

    for (var service in services) {
      if (service.uuid.toString() == _serviceUuid) {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid.toString() == _readingsCharacteristicUuid) {
            _readingsCharacteristic = characteristic;
            print("found service");
          } else if (characteristic.uuid.toString() == _settingsCharacteristicUuid) {
            _settingsCharacteristic = characteristic;
          }
        }
      }
    }
    //listenForReadings();
  }

  void listenForReadings() async {
    if (_readingsCharacteristic == null) return;

    await _readingsCharacteristic!.setNotifyValue(true);

    _readingsCharacteristic!.value.listen((value) {
      final data = jsonDecode(utf8.decode(value));
      AppCtl.to.updateReadingsFromJson(data);
    });
  }
}
