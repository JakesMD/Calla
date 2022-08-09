import 'package:calla/controllers/controllers.dart';
import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

/// A row of 3 [MyHomePageSensorReading]s with a [MyIllustration].
class MyHomePageSensorReadingSection extends StatelessWidget {
  const MyHomePageSensorReadingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          left: MySizeTheme.pageMargin,
          right: MySizeTheme.pageMargin,
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Light:
                MyHomePageSensorReading(
                  text: "${(AppCtl.to.light * 100).toInt()}%",
                  icon: AppCtl.to.light >= 0.25 ? FeatherIcons.sun : FeatherIcons.moon,
                  percent: AppCtl.to.light,
                  color: AppCtl.to.colors.purple,
                ),
                // Spacer for illustration:
                const SizedBox(width: 60),
                // Temperature:
                MyHomePageSensorReading(
                  text: "${AppCtl.to.temperature.toInt()}°C",
                  icon: FeatherIcons.thermometer,
                  percent: 1,
                  color: AppCtl.to.colors.orange,
                ),
                // Humidity:
                MyHomePageSensorReading(
                  text: "${(AppCtl.to.humidity * 100).toInt()}%",
                  icon: FeatherIcons.droplet,
                  percent: AppCtl.to.humidity,
                  color: AppCtl.to.colors.blue,
                ),
              ],
            ),
          ),
        ),
        // Illustration:
        Padding(
          padding: const EdgeInsets.only(top: MySizeTheme.spacing25),
          child: MyIllustration(
            Illustrations.environment,
            width: (Get.width - MySizeTheme.pageMargin) / 2,
            height: null,
          ),
        ),
      ],
    );
  }
}
