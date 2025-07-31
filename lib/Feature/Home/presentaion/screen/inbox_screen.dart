import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constans/app_colors.dart';
import '../../../../../core/constans/responsve_font.dart';
import '../../../../core/constans/fonts.dart';
class CustomHeader extends StatelessWidget {
  final String title;

  const CustomHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Container(
      //  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: AppColors.mainAppColor,
        child: Row(
          children: [
            // IconButton(
            //   icon: const Icon(Icons.arrow_back, color: Colors.white),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
            Expanded(
              child: Text(
                title.tr(),
                style: TextStyle(
                  fontFamily: Fonts.font,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: getFontSize(context, 15),
                ),
               
              ),
            ),
          ],
        ),
      ),
    );
  }
}
