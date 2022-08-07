import 'package:calla/constants/constants.dart';
import 'package:calla/controllers/app_controller.dart';
import 'package:calla/themes/themes.dart';
import 'package:calla/views/pages/home/widgets/home_page_app_bar.dart';
import 'package:calla/views/pages/home/widgets/home_page_sensor_reading.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: MySizeTheme.pageMargin),
          physics: const BouncingScrollPhysics(),
          child: MySpacedColumn(
            spacing: MySizeTheme.spacing25,
            children: [
              const MyHomePageAppBar(),
              Stack(
                children: const [
                  Positioned(
                    child: MyIllustration(
                      Illustrations.environment,
                      width: 200,
                      height: null,
                    ),
                  ),
                ],
              ),
              MyHomePageSensorReading(
                text: "66%",
                icon: CupertinoIcons.drop,
                percent: 0.66,
                color: AppCtl.to.colors.purple,
              )
            ],
          ),
        ),
      ),
    );
  }
}
