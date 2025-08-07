import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/add_advertisement_bloc/add_advertisement_bloc.dart';
import 'dart:io';

import 'package:lahijcenter/Feature/AddAdvertisement/blocs/currency_bloc/currency_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/government_bloc/government_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/data/model/government_model.dart';
import 'package:lahijcenter/Feature/main/bottomNavbar/Bottomnav.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';

import '../../../../core/utils/services/services_locator.dart';
import '../../blocs/add_advertisement_bloc/add_advertisement_event.dart';
import '../../blocs/category_bloc/category_bloc.dart';
import '../../blocs/services_bloc/services_bloc.dart';
import '../../data/model/currency.dart';
import '../../data/model/group.dart';
import '../../data/model/services.dart';

class AddAdvertisementScreen extends StatefulWidget {
  const AddAdvertisementScreen({super.key});

  @override
  State<AddAdvertisementScreen> createState() => _AddAdvertisementScreenState();
}

class _AddAdvertisementScreenState extends State<AddAdvertisementScreen> {
  Services? selectedService;
  ModelCurrency? selectedCurrency;
  Group? selectedCategory;
  Government? selectedGovernorate;
  bool? isReplyClosed = false;
  final List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  final int _maxImages = 8;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  Future<void> pickImageFromCamera() async {
    if (_selectedImages.length >= _maxImages) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You can only select up to $_maxImages images')),
      );
      return;
    }
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  Future<void> pickImageFromGallery() async {
    if (_selectedImages.length >= _maxImages) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You can only select up to $_maxImages images')),
      );
      return;
    }
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        final remainingSlots = _maxImages - _selectedImages.length;
        final filesToAdd = pickedFiles.take(remainingSlots).map((e) => File(e.path)).toList();
        _selectedImages.addAll(filesToAdd);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRowLabelField("اسم الاعلان", textField(hint: 'اضف اسم الاعلان', green: green,controller: _titleController)),
              buildRowLabelField("رقم الجوال", textField(hint: 'رقم الجوال', inputType: TextInputType.phone, green: green,controller: _phoneController)),
              buildRowLabelField(
                "الخدمة",
                BlocBuilder<ServicesBloc, BaseState<Services>>(
                  builder: (context, state) {
                    return buildDropdown<Services>(
                      value: selectedService,
                      items: state.items,
                      displayText: (item) => item.name ?? '',
                      onChanged: (val) => setState(() => selectedService = val),
                      hint: "اختر الخدمة",
                      green: green,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 100.w, child: label('السعر', green)),

                    Expanded(
                      child: BlocBuilder<CurrencyBloc, BaseState<ModelCurrency>>(
                        builder: (context, state) {
                          return buildDropdown<ModelCurrency>(
                            value: selectedCurrency,
                            items: state.items,
                            displayText: (item) => item.arName ?? '',
                            onChanged: (val) => setState(() => selectedCurrency = val),
                            hint: 'اختر العملة',
                            green: green,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 100.w, child: label('السعر', green)),
                  Expanded(
                    child: textField(hint: 'اضف السعر', green: green,controller: _priceController),
                  ),

                ],
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

              buildRowLabelField(
                "القسم الرئيسي",
                BlocBuilder<CategoryBloc, BaseState<Group>>(
                  builder: (context, state) {
                    return buildDropdown<Group>(
                      value: selectedCategory,
                      items: state.items,
                      displayText: (item) => item.arName ?? '',
                      onChanged: (val) => setState(() => selectedCategory = val),
                      hint: "اختر القسم",
                      green: green,
                    );
                  },
                ),
              ),
              buildRowLabelField(
                "المحافظة",
                BlocBuilder<GovernmentBloc, BaseState<Government>>(
                  builder: (context, state) {
                    return buildDropdown<Government>(
                      value: selectedGovernorate,
                      items: state.items,
                      displayText: (item) => item.arName ?? '',
                      onChanged: (val) => setState(() => selectedGovernorate = val),
                      hint: "اختر المحافظة",
                      green: green,
                    );
                  },
                ),
              ),

              label('صور الاعلان', green),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    if (_selectedImages.isNotEmpty) ...[
                      SizedBox(
                        height: 150.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _selectedImages.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  width: 200.w,
                                  margin: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 8.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Image.file(
                                      _selectedImages[index],
                                      width: 200.w,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () => _removeImage(index),
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.close, color: Colors.white, size: 16),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ],
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: pickImageFromCamera,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.camera_alt_outlined, size: 32.sp, color: green),
                                  SizedBox(height: 4.h),
                                  Text("الكاميرا", style: TextStyle(fontSize: 12.sp)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: GestureDetector(
                            onTap: pickImageFromGallery,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.photo_library_outlined, size: 32.sp, color: green),
                                  SizedBox(height: 4.h),
                                  Text("المعرض", style: TextStyle(fontSize: 12.sp)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "يمكنك إضافة حتى 8 صور (${_selectedImages.length}/8)",
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
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
                  validator: (value) => value!.isEmpty ? 'برجاء ادخال التفاصيل' : null,
                  controller: _descController,
                  decoration: InputDecoration(
                    hintText: "اكتب التفاصيل هنا ...",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              BlocProvider(
                create: (context) => sl<AddAdvertisementBloc>(),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: BlocConsumer<AddAdvertisementBloc, BaseState<void>>(
                     listener: (context, state) {
                      if(state.isSuccess){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم إضافة الإعلان بنجاح")));
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Bottomnav()), (route)=>false);
                      }
                    if(state.isFailure){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage??"حدث خطأ ما")));
                    }

                    },
                    builder: (context, state) {
                      return state.isLoading?const Center(child: CircularProgressIndicator()): ElevatedButton(
                        onPressed: () {
          if(_formKey.currentState!.validate()){
            if(_selectedImages.length<5){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("يجب اختيار على الاقل 5 صور")));
return;
            }
                          context.read<AddAdvertisementBloc>().add(SubmitAdvertisement(name: _titleController.text.trim(), phone: _phoneController.text.trim(), groupId: selectedCategory?.id??0, serviceId: selectedService?.id??0, price: num.tryParse(_priceController.text.trim())?.toDouble()??0, isCloseReplies: isReplyClosed??false, currencyId: selectedCurrency?.id??0, governorateId: selectedGovernorate?.id??0, area: "", description: _descController.text.trim(), images: _selectedImages));
          }
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: green),
                        child: Text(
                          "اضف الاعلان",
                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                      );
                    }
                  ),
                ),
              ),
            ],
          ),
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

  Widget textField({String? hint, TextInputType? inputType, required Color green,required TextEditingController controller}) => TextFormField(
    controller: controller,
        keyboardType: inputType,
        validator: (value) => value!.isEmpty ? 'برجاء ادخال $hint' : null,
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

  Widget buildDropdown<T>({
    required T? value,
    required List<T> items,
    required String Function(T) displayText,
    required void Function(T?) onChanged,
    required String hint,
    required Color green,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(displayText(item)),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'برجاء اختيار $hint' : null,
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
}
