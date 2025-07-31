import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constans/fonts.dart';

class CustomDeleteSuccessDialog extends StatelessWidget {
  const CustomDeleteSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "تم حذف الإعلان",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Fonts.font,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomLeft,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child:  Text(
                "حسناً",
                style: TextStyle(
                  fontFamily: Fonts.font,
                  color: Colors.green,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
