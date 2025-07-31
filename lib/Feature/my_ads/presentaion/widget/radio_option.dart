import 'package:flutter/material.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/fonts.dart';
import '../../../../core/constans/responsve_font.dart';

class RadioOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final ValueChanged<bool> onChanged;

  const RadioOption({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<bool>(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: Fonts.font,
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: getFontSize(context, 12),
        ),
      ),
      value: true,
      groupValue: isSelected ? true : false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      activeColor: AppColors.mainAppColor,
      fillColor: MaterialStateProperty.resolveWith<Color>((states) {
        return AppColors.mainAppColor;
      }),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}
