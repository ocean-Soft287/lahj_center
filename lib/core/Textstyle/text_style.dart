import 'dart:ui';

import 'package:flutter/material.dart';
import '../constans/app_colors.dart';
import '../constans/fonts.dart';
import '../constans/responsve_font.dart';
import '../constans/sizeconfig.dart';
abstract class Textstylefont {
  static TextStyle usetermsstyle(BuildContext context) {
    return TextStyle(
      color: Colors.white,
fontFamily: Fonts.font,
      fontWeight: FontWeight.w900,

      fontSize: getResponsiveFontSize(context, fontSize: 25),

    );
  }
static TextStyle sectionSubtitle(BuildContext context){
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 17),
      fontWeight: FontWeight.w500,
      fontFamily: Fonts.font,
      color: const Color(0xff3C3C3C),
  );
}
static TextStyle sectionTitle(BuildContext context){
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 25),
      fontFamily: Fonts.font,
      fontWeight: FontWeight.w800,
      color: AppColors.mainAppColor,
    );

}
static TextStyle titlewelcome(BuildContext context){
    return TextStyle(
        fontFamily: Fonts.font,
        color: AppColors.secondAppColor,
        fontWeight: FontWeight.w700,
        fontSize: getFontSize(context, 24));

}
static TextStyle logintext(BuildContext context){
    return TextStyle(
fontFamily: Fonts.font,
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: getFontSize(context, 16));

}


static double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
    double scaleFactor = getScaleFactor(context);
    double responsiveFontSize = fontSize * scaleFactor;

    double lowerLimit = fontSize * .8;
    double upperLimit = fontSize * 1.2;

    return responsiveFontSize.clamp(lowerLimit, upperLimit);
  }

  static double getScaleFactor(BuildContext context) {
    var dispatcher = PlatformDispatcher.instance;
    var physicalWidth = dispatcher.views.first.physicalSize.width;
    var devicePixelRatio = dispatcher.views.first.devicePixelRatio;
    double width = physicalWidth / devicePixelRatio;

    if (width < SizeConfig.tablet) {
      return width / 550;
    } else if (width < SizeConfig.desktop) {
      return width / 1000;
    } else {
      return width / 1920;
    }
  }
}
