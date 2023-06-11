import 'package:barts/consts/colors.dart';
import 'package:flutter/material.dart';

TextStyle ourStyles({String family = 'regular', double size = 14, Color color = Colors.white}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontFamily: family,
  );
}