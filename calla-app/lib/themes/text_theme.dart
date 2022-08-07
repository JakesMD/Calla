import 'package:calla/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// TODO: Add the fonts as assets when we know for definite which font to use.

// ignore: non_constant_identifier_names
final TextTheme MyTextTheme = GoogleFonts.poppinsTextTheme(
  TextTheme(
    headline1: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: AppCtl.to.colors.text,
    ),
    headline2: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppCtl.to.colors.text,
    ),
    headline3: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppCtl.to.colors.text,
    ),
    headline4: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppCtl.to.colors.text,
    ),
    headline5: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppCtl.to.colors.text,
    ),
    bodyText1: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: AppCtl.to.colors.text,
    ),
    bodyText2: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: AppCtl.to.colors.text,
    ),
  ),
);
