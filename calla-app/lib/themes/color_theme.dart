import 'package:flutter/material.dart';

/// The class is a custom color theme that also contains the colors for light and dark mode.
class MyColorTheme {
  final Color text;
  final Color background;

  final Color green;
  final Color orange;
  final Color blue;
  final Color purple;
  final Color pink;

  MyColorTheme({
    required this.text,
    required this.background,
    required this.green,
    required this.orange,
    required this.blue,
    required this.purple,
    required this.pink,
  });

  factory MyColorTheme.light() => MyColorTheme(
        text: const Color(0xFF292C3C),
        background: const Color(0xFFFFFFFF),
        green: const Color(0xFFCDE885),
        orange: const Color(0xFFFFD182),
        blue: const Color(0xFFAEE7FF),
        purple: const Color(0xFFB3BAE8),
        pink: const Color(0xFFFFBCF6),
      );

  // TODO: create dark mode colors.
  factory MyColorTheme.dark() => MyColorTheme(
        text: const Color(0xFF292C3C),
        background: const Color(0xFFFFFFFF),
        green: const Color(0xFFCDE885),
        orange: const Color(0xFFFFD182),
        blue: const Color(0xFFAEE7FF),
        purple: const Color(0xFFB3BAE8),
        pink: const Color(0xFFFFBCF6),
      );
}
