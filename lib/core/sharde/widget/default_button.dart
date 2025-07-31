import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lahijcenter/core/constans/responsve_font.dart';

import '../../constans/fonts.dart';





class DefaultButton extends StatelessWidget {
  final String text;
  final Function function;
  final Color backgroundColor;
  final Color textColor;
  final bool hasIcon;
  final Widget? icon;
  final double heightButton;

  const DefaultButton({
    super.key,
    required this.text,
    required this.function,
    this.backgroundColor = const Color(0xff54BC64
    ),
    this.textColor = Colors.white,
    this.hasIcon = false,
    this.icon,
    this.heightButton=45,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(7.0.r),
      ),
      width: double.infinity,
      height: heightButton.h,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasIcon && icon != null) icon!,
            const SizedBox(width: 10,),
            Text(
              text,
              style:  TextStyle(  fontFamily: Fonts.font,
                fontSize: getFontSize(context, 14),
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

