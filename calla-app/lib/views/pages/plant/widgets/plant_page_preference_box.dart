import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// A colored container that represents a plant preference.
class MyPlantPagePreferenceBox extends StatelessWidget {
  final IconData icon;
  final String headline;
  final String text;
  final String suffixText;
  final Color color;
  final Function()? onTap;

  const MyPlantPagePreferenceBox({
    Key? key,
    required this.icon,
    required this.headline,
    required this.text,
    required this.color,
    this.suffixText = "",
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyClickable(
      height: 80,
      color: color,
      borderRadius: MySizeTheme.borderRadius10,
      onTap: onTap,
      child: MySpacedRow(
        padding: const EdgeInsets.all(MySizeTheme.spacing15),
        children: [
          MyIcon(icon),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "$headline\n",
                style: MyTextTheme.bodyText2,
                children: [
                  TextSpan(
                    text: text,
                    style: MyTextTheme.headline3,
                  ),
                  TextSpan(text: " $suffixText"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
