import 'package:flutter/material.dart';

import '../../../../../core/constans/fonts.dart';
import '../../../../../core/constans/responsve_font.dart';
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Center(
          child: Text(
            "الاشعارات",
            style: TextStyle(
              fontFamily: Fonts.font,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: getFontSize(context, 15),
            ),

          ),
        ),
      ],
    );
  }
}