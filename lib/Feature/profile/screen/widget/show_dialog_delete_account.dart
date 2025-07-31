import 'package:flutter/material.dart';
import 'package:lahijcenter/core/constans/app_colors.dart';

import '../../../../../../core/constans/fonts.dart';
import '../../../../../../core/constans/responsve_font.dart';

void showdeleteaccountdialog(BuildContext context, {required VoidCallback onDelete}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(

        title: Text("انتباه",style: TextStyle(
            fontFamily: Fonts.font,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: getFontSize(context,16)
        ),
        textAlign: TextAlign.center,),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("هل أنت متأكد أنك تريد حذف حسابك؟"
            'سيؤدي حذف الحساب إلى مسح جميع البيانات المرتبطة به'
          ,style: TextStyle(
                  fontFamily: Fonts.font,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: getFontSize(context,14)
            ),
              textAlign: TextAlign.center,),
          ],
        ),
        actions: [
          TextButton(
            child: Text("حذف",style: TextStyle(
                fontFamily: Fonts.font,
                color: Colors.red,
                fontWeight: FontWeight.w500,
                fontSize: getFontSize(context,14)
            ),), 
            onPressed: () {
              onDelete();
            },
          ),
          TextButton(
            child: Text("رجوع",style: TextStyle(
                fontFamily: Fonts.font,
      color: AppColors.mainAppColor,
      fontWeight: FontWeight.w500,
      fontSize: getFontSize(context,14)
      )),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
