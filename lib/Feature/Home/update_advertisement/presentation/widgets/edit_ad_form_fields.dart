import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Data/model/item_model.dart' as ItemModels;

class EditAdFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController phoneController;
  final TextEditingController priceController;
  final ItemModels.Item item;
  final Color green;

  const EditAdFormFields({
    super.key,
    required this.titleController,
    required this.phoneController,
    required this.priceController,
    required this.item,
    required this.green,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // اسم الاعلان
        buildRowLabelField(
          "اسم الاعلان",
          textField(hint: item.name, green: green, controller: titleController),
        ),
        const Divider(color: Color(0xff868686), thickness: 1.5),

        // رقم الجوال
        buildRowLabelField(
          "رقم الجوال",
          textField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            hint: item.phone,
            inputType: TextInputType.phone,
            green: green,
            controller: phoneController,
          ),
        ),
        const Divider(color: Color(0xff868686), thickness: 1.5),

        // السعر يتم التعامل معه في صف مستقل في الملف الأصلي، سأبقي عليه هنا للتنظيم
        Row(
          children: [
            SizedBox(width: 100.w, child: label('السعر', green)),
            Expanded(
              child: textField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                hint: item.price.toString(),
                green: green,
                controller: priceController,
              ),
            ),
          ],
        ),
        const Divider(color: Color(0xff868686), thickness: 1.5),
      ],
    );
  }

  Widget buildRowLabelField(String title, Widget field) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 100.w, child: label(title, Colors.green)),
          Expanded(child: field),
        ],
      ),
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

  Widget textField({
    String? hint,
    TextInputType? inputType,
    required Color green,
    required TextEditingController controller,
    List<TextInputFormatter>? inputFormatters,
  }) => TextFormField(
    controller: controller,
    keyboardType: inputType,
    inputFormatters: inputFormatters,
    decoration: InputDecoration(
      hintText: hint ?? '',
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: green),
        borderRadius: BorderRadius.circular(8.r),
      ),
    ),
  );
}
