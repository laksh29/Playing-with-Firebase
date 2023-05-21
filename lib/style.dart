import 'package:flutter/material.dart';

TextStyle buildHintStyle() {
  return TextStyle(
    color: Colors.grey.withOpacity(0.1),
    fontWeight: FontWeight.w400,
  );
}

OutlineInputBorder buildBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: color, width: 2.0),
  );
}

SizedBox buildHeight(double height) => SizedBox(height: height);
SizedBox buildWidth(double width) => SizedBox(width: width);
