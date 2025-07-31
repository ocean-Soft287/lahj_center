
import 'custom_ad_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class NameaddMobilewidget extends StatelessWidget {
  const NameaddMobilewidget({
    super.key,
    required this.name,
    required this.phoneController,
  });

  final TextEditingController name;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          CustomAdField(

            label: "اسم الاعلان",
            hintText: "اضف اسم الاعلان",
            validationMessage: 'برجاء كتابه اسم الاعلان',
            controller: name,
            validator: (value) {
              debugPrint("Name Validator: value='$value'");
              if (value == null || value.trim().isEmpty) {
                debugPrint("Name validation failed: Field is empty");
                return 'برجاء كتابه اسم الاعلان';
              }
              if (value.trim().length < 3) {
                debugPrint("Name validation failed: Name too short");
                return 'اسم الاعلان يجب أن يكون 3 أحرف على الأقل';
              }
              return null;
            },
          ),
          CustomAdField(
            label: "رقم الجوال",
            hintText: "+967#######",
            textInputType: TextInputType.phone,
            validationMessage: 'برجاء ادخال رقم الجوال',
            controller: phoneController,
            validator: (value) {
              debugPrint("Phone Validator: value='$value'");
              if (value == null || value.trim().isEmpty) {
                debugPrint("Phone validation failed: Field is empty");
                return 'برجاء ادخال رقم الجوال';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}