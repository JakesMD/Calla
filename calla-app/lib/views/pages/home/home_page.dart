import 'package:calla/constants/illustrations.dart';
import 'package:calla/views/widgets/illustration.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyIllustration(Illustrations.environment),
    );
  }
}
