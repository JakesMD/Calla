import 'package:calla/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

/// The default rightToLeftWithFade transition for navigation.
class MyPageTransition implements CustomTransition {
  @override
  Widget buildTransition(context, curve, alignment, anim1, anim2, child) {
    var easeAnim1 = CurvedAnimation(parent: anim1, curve: MyCurveTheme.ease);
    var easeAnim2 = CurvedAnimation(parent: anim2, curve: MyCurveTheme.ease);

    var offset1 = Tween<Offset>(begin: const Offset(0.5, 0.0), end: Offset.zero).animate(easeAnim1);
    var offset2 =
        Tween<Offset>(begin: Offset.zero, end: const Offset(-0.5, 0.0)).animate(easeAnim2);

    return SlideTransition(
      position: offset1,
      child: SlideTransition(
        position: offset2,
        child: FadeTransition(opacity: easeAnim1, child: child),
      ),
    );
  }
}
