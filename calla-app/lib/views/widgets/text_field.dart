import 'package:calla/controllers/app_controller.dart';
import 'package:calla/themes/themes.dart';
import 'package:calla/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// A custom text field.
class MyTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController? controller;

  const MyTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MySizeTheme.buttonHeight,
      child: TextField(
        controller: controller,
        maxLength: 20,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: MySizeTheme.spacing10),
          fillColor: AppCtl.to.colors.pink,
          filled: false,
          hintText: hintText,
          hintStyle: MyTextTheme.bodyText1!.copyWith(color: AppCtl.to.colors.purple),
          prefixIcon: MyIcon(icon, color: AppCtl.to.colors.purple),
          counterText: "",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(MySizeTheme.borderRadius10),
            borderSide: BorderSide(
              color: AppCtl.to.colors.purple,
              width: MySizeTheme.borderWidth25,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(MySizeTheme.borderRadius10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
