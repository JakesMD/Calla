import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyHomePageSensorReading extends StatelessWidget {
  final String text;
  final IconData icon;
  final double percent;
  final Color color;

  const MyHomePageSensorReading({
    Key? key,
    required this.text,
    required this.icon,
    required this.percent,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MySpacedColumn(
      spacing: MySizeTheme.spacing10,
      children: [
        CircularPercentIndicator(
          percent: percent,
          center: MyIcon(icon),
          radius: 30,
          progressColor: color,
          backgroundColor: Colors.transparent,
          circularStrokeCap: CircularStrokeCap.round,
          animation: true,
          animateFromLastPercent: true,
          animationDuration: MyDurationTheme.m500.inMilliseconds,
          curve: MyCurveTheme.easeOut,
        ),
        Text(
          text,
          style: MyTextTheme.headline3,
        )
      ],
    );
  }
}
