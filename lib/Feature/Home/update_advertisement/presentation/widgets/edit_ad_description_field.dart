import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Data/model/item_model.dart' as ItemModels;

class EditAdDescriptionField extends StatelessWidget {
  final TextEditingController controller;
  final ItemModels.Item item;
  final Color green;

  const EditAdDescriptionField({
    super.key,
    required this.controller,
    required this.item,
    required this.green,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: label("وصف الاعلان", green),
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            border: Border.all(color: green),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: TextFormField(
            maxLines: 4,
            controller: controller,
            decoration: InputDecoration(
              hintText: item.description,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget label(String text, Color color) => Center(
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.sp,
        color: color,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
