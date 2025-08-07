import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddAdvertisementScreen extends StatefulWidget {
  const AddAdvertisementScreen({super.key});

  @override
  State<AddAdvertisementScreen> createState() => _AddAdvertisementScreenState();
}

class _AddAdvertisementScreenState extends State<AddAdvertisementScreen> {
  String? selectedService;
  String? selectedCurrency;
  String? selectedCategory;
  String? selectedGovernorate;
  bool? isReplyClosed = false;
  File? image1;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        image1 = File(pickedFile.path);
      });
    }
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image1 = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    Color green = Colors.green;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'اضافة اعلان',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRowLabelField("اسم الاعلان", textField(hint: 'اضف اسم الاعلان', green: green)),
            buildRowLabelField("رقم الجوال", textField(hint: 'رقم الجوال', inputType: TextInputType.phone, green: green)),
            buildRowLabelField("الخدمة", dropdownField(value: selectedService, items: ['خدمة 1', 'خدمة 2'], hint: "اختر الخدمة", onChanged: (val) => setState(() => selectedService = val), green: green)),

            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 100.w, child: label('السعر', green)),
                  Expanded(
                    child: textField(hint: 'اضف السعر', green: green),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: dropdownField(
                      value: selectedCurrency,
                      hint: 'اختر العملة',
                      items: ['ريال', 'دولار'],
                      onChanged: (val) => setState(() => selectedCurrency = val),
                      green: green,
                    ),
                  ),
                ],
              ),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 100.w, child: label('اغلاق الردود', green)),
                Radio<bool>(
                  value: true,
                  groupValue: isReplyClosed,
                  onChanged: (value) => setState(() => isReplyClosed = value),
                  activeColor: green,
                ),
                Text("نعم"),
                SizedBox(width: 20.w),
                Radio<bool>(
                  value: false,
                  groupValue: isReplyClosed,
                  onChanged: (value) => setState(() => isReplyClosed = value),
                  activeColor: green,
                ),
                Text("لا"),
              ],
            ),
            SizedBox(height: 12.h),

            buildRowLabelField("القسم الرئيسي", dropdownField(value: selectedCategory, items: ['الكترونيات', 'سيارات', 'خدمات'], hint: "اختر القسم", onChanged: (val) => setState(() => selectedCategory = val), green: green)),
            buildRowLabelField("المحافظة", dropdownField(value: selectedGovernorate, items: ['القاهرة', 'الجيزة', 'الاسكندرية'], hint: "اختر المحافظة", onChanged: (val) => setState(() => selectedGovernorate = val), green: green)),

            label('صورة الاعلان', green),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: pickImageFromCamera,
                          child: Column(
                            children: [
                              Icon(Icons.camera_alt_outlined, size: 40),
                              SizedBox(height: 4.h),
                              Text("استخدام الكاميرا"),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 50.h,
                        width: 1,
                        color: Colors.grey.shade400,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: pickImageFromGallery,
                          child: Column(
                            children: [
                              Icon(Icons.photo_library_outlined, size: 40),
                              SizedBox(height: 4.h),
                              Text("تحميل الصور"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "صور الاعلان يجب أن تكون من 5 الى 8 صور",
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  if (image1 != null) ...[
                    SizedBox(height: 12.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.file(image1!, height: 150.h),
                    )
                  ]
                ],
              ),
            ),

            SizedBox(height: 12.h),
            label("وصف الاعلان", green),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                border: Border.all(color: green),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "اكتب التفاصيل هنا ...",
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 24.h),

            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: green),
                child: Text(
                  "اضف الاعلان",
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRowLabelField(String title, Widget field) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
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
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp, color: color),
      textAlign: TextAlign.center,
    ),
  );

  Widget textField({String? hint, TextInputType? inputType, required Color green}) => TextFormField(
    keyboardType: inputType,
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

  Widget dropdownField({
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    String? hint,
    required Color green,
  }) =>
      DropdownButtonFormField<String>(
        value: items.contains(value) ? value : null,
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: green),
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: green),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      );
}
