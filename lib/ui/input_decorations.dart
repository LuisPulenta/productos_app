import 'package:flutter/material.dart';

//---------------------------------------------------------------------------
class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      // border: OutlineInputBorder(
      //   borderRadius: BorderRadius.all(
      //     Radius.circular(15),
      //   ),
      // ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepPurple,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurple, width: 2),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.grey),
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: Colors.deepPurple)
          : null,
    );
  }

//---------------------------------------------------------------------------
  static InputDecoration authInputDecoration2({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.grey),
      prefixIcon:
          prefixIcon != null ? Icon(prefixIcon, color: Colors.red) : null,
    );
  }
}
