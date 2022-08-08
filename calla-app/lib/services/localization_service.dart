import 'package:calla/lang/languages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The service that handles the translations.
class LocalizationSvc extends Translations {
  /// The current locale. Default: [Get.deviceLocale].
  static Locale? locale = Get.deviceLocale;

  /// The fallback local for when an invalid locale is selected.
  static const fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
      };

  /// Updates the translations to the given [newLocale].
  void updateLocale(Locale newLocale) {
    locale = newLocale;
    Get.updateLocale(newLocale);
  }
}
