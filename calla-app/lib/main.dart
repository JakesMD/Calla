import 'package:calla/controllers/controllers.dart';
import 'package:calla/services/services.dart';
import 'package:calla/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the services.
  await Get.putAsync(() => AssetSvc().init());

  // Initialize the controllers.
  await Get.putAsync(() => AppCtl().init());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Calla',
      debugShowCheckedModeBanner: false,

      // Themes:
      theme: ThemeData(
        textTheme: MyTextTheme,
        scaffoldBackgroundColor: AppCtl.to.colors.background,
      ),

      // Internationalization:
      translations: LocalizationSvc(),
      locale: LocalizationSvc.locale,
      fallbackLocale: LocalizationSvc.fallbackLocale,

      // Navigation:
      home: Container(),
    );
  }
}
