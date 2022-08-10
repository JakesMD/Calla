import 'package:get/get.dart';

/// The service that handles all the bluetooth connectivity and serial.
class BluetoothSvc extends GetxService {
  /// The current instance of [BluetoothSvc].
  static final BluetoothSvc to = Get.find<BluetoothSvc>();

  /// Initializes the [BluetoothSvc] and returns an instance of it.
  Future<BluetoothSvc> init() async {
    return this;
  }
}
