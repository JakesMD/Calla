import 'package:calla/helpers/range.dart';
import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// A custom [Slider] with a prefix icon and trailing text.
class MySlider extends StatelessWidget {
  final double value;
  final IconData icon;
  final String text;
  final Range range;
  final int? divisions;
  final Function(double)? onChanged;

  const MySlider({
    Key? key,
    required this.value,
    required this.icon,
    required this.text,
    required this.range,
    this.divisions,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyIcon(icon),
            Text(
              text,
              style: MyTextTheme.bodyText1,
            ),
          ],
        ),
        Slider(
          value: value,
          onChanged: onChanged,
          divisions: divisions,
          min: range.min.toDouble(),
          max: range.max.toDouble(),
          label: text,
        ),
      ],
    );
  }
}

/// A custom [RangeSlider] with a prefix icon and trailing text.
class MyRangeSlider extends StatelessWidget {
  final RangeValues values;
  final IconData icon;
  final String textStart;
  final String textEnd;
  final String textSuffix;
  final Range range;
  final int? divisions;
  final Function(RangeValues)? onChanged;

  const MyRangeSlider({
    Key? key,
    required this.values,
    required this.icon,
    required this.textStart,
    required this.textEnd,
    required this.textSuffix,
    required this.range,
    this.divisions,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyIcon(icon),
            Text(
              "$textStart - $textEnd$textSuffix",
              style: MyTextTheme.bodyText1,
            ),
          ],
        ),
        RangeSlider(
          values: values,
          onChanged: onChanged,
          divisions: divisions,
          min: range.min.toDouble(),
          max: range.max.toDouble(),
          labels: RangeLabels(textStart, textEnd),
        ),
      ],
    );
  }
}
