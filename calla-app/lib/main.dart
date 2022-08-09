import 'package:calla/constants/constants.dart';
import 'package:calla/controllers/controllers.dart';
import 'package:calla/services/services.dart';
import 'package:calla/themes/themes.dart';
import 'package:calla/views/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the services.
  await Get.putAsync(() => AssetSvc().init());
  await Get.putAsync(() => PrefsSvc().init());
  await Get.putAsync(() => FileSvc().init());

  // Initialize the controllers.
  await Get.putAsync(() => AppCtl().init());
  Get.put(PlantPageCtl());

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

      // Navigation
      customTransition: MyPageTransition(),
      transitionDuration: MyDurationTheme.m250,
      home: const HomePage(),
      getPages: [
        GetPage(
          name: AppRoutes.home,
          page: () => const HomePage(),
        ),
        GetPage(
          name: AppRoutes.plant,
          page: () => const PlantPage(),
        ),
      ],
    );
  }
}
