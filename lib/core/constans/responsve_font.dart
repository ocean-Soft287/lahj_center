import 'package:flutter/cupertino.dart';

double getFontSize( context, double baseSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  return screenWidth < 600 ? baseSize : baseSize * 1.5;
}