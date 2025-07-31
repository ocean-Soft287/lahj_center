import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/fonts.dart' show Fonts;
import '../../../../core/constans/responsve_font.dart';
import '../../../../core/sharde/widget/text_forn_field.dart';

class CustomAdField extends StatelessWidget {
  final String label;
  final String hintText;
  final String validationMessage;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType? textInputType;
  const CustomAdField({
    super.key,
    required this.label,
    required this.hintText,
    required this.validationMessage,
    required this.validator,
    required this.controller,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label.tr(),
              style: TextStyle(
                fontFamily: Fonts.font,
                color: AppColors.mainAppColor,
                fontWeight: FontWeight.w500,
                fontSize: getFontSize(context, 16),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * .6,
              child: CustomTextFormField(
                textInputType: textInputType,
              controller: controller,
                hintText: hintText.tr(),
                validator: validator,
              ),
            ),
          ],
        ),
        const Divider(
          thickness: 1,
          color: Color(0xff868686),
        ),
      ],
    );
  }
}
