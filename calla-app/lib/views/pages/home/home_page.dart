import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: MySizeTheme.pageMargin),
          physics: BouncingScrollPhysics(),
          child: MySpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: MySizeTheme.spacing50,
            children: [
              MyHomePageAppBar(),
              MyHomePageSensorReadingSection(),
              MyHomePagePlantSection(),
            ],
          ),
        ),
      ),
    );
  }
}
