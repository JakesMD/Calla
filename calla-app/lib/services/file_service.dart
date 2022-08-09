import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// The service that handles files and images in the local storage.
class FileSvc extends GetxService {
  /// The current instance of [FileSvc].
  static final FileSvc to = Get.find<FileSvc>();

  /// The instance of Uuid (a unique id generator used for file names).
  final _uuid = const Uuid();

  final _imagePicker = ImagePicker();

  final Rx<String> _tempImagePath = "".obs;

  late String documentsDirPath;

  /// The path of the temporary selected image.
  String get tempImagePath => _tempImagePath.value;
  set tempImagePath(String path) => _tempImagePath.value = path;

  /// Initializes the [FileSvc] and returns an instance of it.
  Future<FileSvc> init() async {
    documentsDirPath = (await getApplicationDocumentsDirectory()).path;
    return this;
  }

  /// Picks an image from the source and save it to [tempImage];
  Future<bool> pickTempImage(ImageSource source) async {
    try {
      final image = await _imagePicker.pickImage(source: source);

      if (image != null) {
        _tempImagePath.value = image.path;
      }

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  /// Save [tempImage] to a perminant location in the application documents directory.
  Future<String?> saveTempImage() async {
    try {
      if (_tempImagePath.value.isNotEmpty && !_tempImagePath.startsWith(documentsDirPath)) {
        final newPath = _uuid.v1();
        await File(_tempImagePath.value).copy("$documentsDirPath/$newPath");
        return newPath;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
