// Assuming MainTitle is a custom presentaion, if not, replace with Text
import 'package:flutter/cupertino.dart';

import '../../../../core/constans/fonts.dart';

class MainTitle extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextOverflow overflow;
  final int maxLines;

  const MainTitle({
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    required this.overflow,
    required this.maxLines,
    super.key,
  });
////
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:TextStyle(
        fontFamily: Fonts.font,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}