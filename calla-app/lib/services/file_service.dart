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

  /// The instance of [ImagePicker] (that picks images from the camera or gallery).
  final _imagePicker = ImagePicker();

  final Rx<String> _tempImagePath = "".obs;

  /// The path of the app documents directory.
  late String documentsDirPath;

  /// The path of the temporary selected image.
  String get tempImagePath => _tempImagePath.value;
  set tempImagePath(String path) => _tempImagePath.value = path;

  /// Initializes the [FileSvc] and returns an instance of it.
  Future<FileSvc> init() async {
    // Fetch the path of the app documents directory.
    documentsDirPath = (await getApplicationDocumentsDirectory()).path;
    return this;
  }

  /// Picks an image from the source and save it to [tempImage];
  Future<bool> pickTempImage(ImageSource source) async {
    try {
      // Pick an image from either the camera or gallery.
      final image = await _imagePicker.pickImage(source: source);

      // Save the location of the image to the temp image.
      if (image != null) {
        tempImagePath = image.path;
      }

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  /// Save [tempImage] to a permanant location in the application documents directory.
  Future<String?> saveTempImage() async {
    try {
      // If there is a temp image and the temp image isn't already saved.
      if (tempImagePath.isNotEmpty && !tempImagePath.startsWith(documentsDirPath)) {
        final newPath = _uuid.v1(); // Create a unique id for the file.

        // Copy the temporary file and save it to the new path.
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
