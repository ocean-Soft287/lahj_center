import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/sub_area_bloc/sub_area_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/sub_catagory_bloc/sub_catagory_cubit.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/data/model/sub_area_model.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/data/model/sub_group_model.dart';
import 'package:lahijcenter/Feature/Home/update_advertisement/data/models/advertisement_responce.dart';
import 'package:lahijcenter/core/Textstyle/extention.dart';
import 'package:lahijcenter/core/utils/services/services_locator.dart';

import '../../../../../core/bloc/base_state.dart';
import '../../../../../core/constans/app_colors.dart';
import '../../../../AddAdvertisement/blocs/category_bloc/category_bloc.dart';
import '../../../../AddAdvertisement/blocs/currency_bloc/currency_bloc.dart';
import '../../../../AddAdvertisement/blocs/government_bloc/government_bloc.dart';
import '../../../../AddAdvertisement/blocs/services_bloc/services_bloc.dart';
import '../../../../AddAdvertisement/data/model/currency.dart';
import '../../../../AddAdvertisement/data/model/government_model.dart';
import '../../../../AddAdvertisement/data/model/group.dart';
import '../../../../AddAdvertisement/data/model/services.dart';
import '../../../Data/model/item_model.dart' as ItemModels; // استخدم prefix
import '../../data/models/update_advertisement_model.dart';
import '../manager/update_cubit.dart';

class EdittAdvertisementScreen extends StatefulWidget {
  final ItemModels.Item item; // استخدم الـ prefix

  const EdittAdvertisementScreen({super.key, required this.item});

  @override
  State<EdittAdvertisementScreen> createState() =>
      _EditAdvertisementScreenState();
}

class _EditAdvertisementScreenState extends State<EdittAdvertisementScreen> {
  Services? selectedService;
  ModelCurrency? selectedCurrency;
  Group? selectedCategory;
  Government? selectedGovernorate;
  SubAreaModel? selectedArea;
  bool? isReplyClosed;
  AdCondition? selectedCondition;
  SubGroupModel? selectedSubCategory;
  
  // قوائم الصور
  final List<File> _selectedImages = []; // صور جديدة من الجهاز
  final List<String> _existingImageUrls = []; // URLs الصور الموجودة
  final List<int> _imagesToDelete = []; // IDs الصور المطلوب حذفها
  
  // نسخة من الصور الأصلية للوصول للـ id - استخدم الـ prefix
  List<ItemModels.AdvertisementImage>? _originalImages;
  
  final ImagePicker _picker = ImagePicker();
  final int _maxImages = 8;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isReplyClosed = widget.item.isCloseReplies;

    // تحميل الصور الموجودة
    if (widget.item.advertisementImages != null &&
        widget.item.advertisementImages!.isNotEmpty) {
      // احفظ نسخة من الصور الأصلية للوصول للـ id
      _originalImages = List.from(widget.item.advertisementImages!);
      
      // احفظ الـ URLs فقط للعرض
      for (var img in widget.item.advertisementImages!) {
        _existingImageUrls.add(img.imageName);
      }
    }

    setState(() {});
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descController.dispose();
    _phoneController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  // التقاط صورة من الكاميرا
  Future<void> pickImageFromCamera() async {
    int totalImages = _existingImageUrls.length + _selectedImages.length;
    if (totalImages >= _maxImages) {
      _showMaxImagesMessage();
      return;
    }

    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  // اختيار صور من المعرض
  Future<void> pickImageFromGallery() async {
    int totalImages = _existingImageUrls.length + _selectedImages.length;
    if (totalImages >= _maxImages) {
      _showMaxImagesMessage();
      return;
    }

    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        final remainingSlots = _maxImages - totalImages;
        final filesToAdd = pickedFiles
            .take(remainingSlots)
            .map((e) => File(e.path))
            .toList();
        _selectedImages.addAll(filesToAdd);
      });
    }
  }

  // حذف صورة موجودة (من السيرفر)
  void _removeExistingImage(int index) {
    if (_originalImages != null && index < _originalImages!.length) {
      setState(() {
        // احصل على الـ id الفعلي من الصورة الأصلية
        final imageId = _originalImages![index].id;
        _imagesToDelete.add(imageId);
        
        // احذف من القوائم
        _existingImageUrls.removeAt(index);
        _originalImages!.removeAt(index);
      });
    }
  }

  // حذف صورة جديدة (من الجهاز)
  void _removeNewImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  // رسالة الحد الأقصى للصور
  void _showMaxImagesMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("لقد وصلت للحد الأقصى من الصور ($_maxImages صور)"),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    Color green = Colors.green;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تعديل الاعلان',
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
            // اسم الاعلان
            buildRowLabelField(
              "اسم الاعلان",
              textField(
                hint: widget.item.name,
                green: green,
                controller: _titleController,
              ),
            ),
            Divider(color: Color(0xff868686), thickness: 1.5),
            
            // رقم الجوال
            buildRowLabelField(
              "رقم الجوال",
              textField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                hint: widget.item.phone,
                inputType: TextInputType.phone,
                green: green,
                controller: _phoneController,
              ),
            ),
            Divider(color: Color(0xff868686), thickness: 1.5),
            
            // حالة الإعلان
            buildRowLabelField(
              "حالة الإعلان",
              buildDropdown<AdCondition>(
                value: selectedCondition,
                items: AdCondition.values,
                displayText: (item) => item.arabicName,
                onChanged: (val) => setState(() => selectedCondition = val),
                hint: conditionArabic(widget.item.condition),
                green: green,
              ),
            ),
            Divider(color: Color(0xff868686), thickness: 1.5),
            
            // الخدمة
            buildRowLabelField(
              "الخدمة",
              BlocBuilder<ServicesBloc, BaseState<Services>>(
                builder: (context, state) {
                  return buildDropdown<Services>(
                    value: selectedService,
                    items: state.items,
                    displayText: (item) => item.name,
                    onChanged: (val) => setState(() => selectedService = val),
                    hint: widget.item.serviceName,
                    green: green,
                  );
                },
              ),
            ),
            Divider(color: Color(0xff868686), thickness: 1.5),
            
            // العملة
            Row(
              children: [
                SizedBox(width: 100.w, child: label('العملة', green)),
                Expanded(
                  child: BlocBuilder<CurrencyBloc, BaseState<ModelCurrency>>(
                    builder: (context, state) {
                      return buildDropdown<ModelCurrency>(
                        value: selectedCurrency,
                        items: state.items,
                        displayText: (item) => item.arName,
                        onChanged: (val) =>
                            setState(() => selectedCurrency = val),
                        hint: widget.item.currencyName,
                        green: green,
                      );
                    },
                  ),
                ),
              ],
            ),
            Divider(color: Color(0xff868686), thickness: 1.5),
            
            // السعر
            Row(
              children: [
                SizedBox(width: 100.w, child: label('السعر', green)),
                Expanded(
                  child: textField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    hint: widget.item.price.toString(),
                    green: green,
                    controller: _priceController,
                  ),
                ),
              ],
            ),
            Divider(color: Color(0xff868686), thickness: 1.5),
            
            // اغلاق الردود
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
            Divider(color: Color(0xff868686), thickness: 1.5),
            
            // القسم الرئيسي
            buildRowLabelField(
              "القسم الرئيسي",
              BlocBuilder<CategoryBloc, BaseState<Group>>(
                builder: (context, state) {
                  return buildDropdown<Group>(
                    hint: widget.item.groupName,
                    green: green,
                    value: selectedCategory,
                    items: state.items,
                    displayText: (item) => item.arName,
                    onChanged: (val) {
                      setState(() => selectedCategory = val);
                      context.read<SubCatagoryCubit>().getSubCatagory(val!.id);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Divider(color: Color(0xff868686), thickness: 1.5),
            ),

            // القسم الفرعي
            buildRowLabelField(
              "القسم الفرعي",
              BlocBuilder<SubCatagoryCubit, BaseState<SubGroupModel>>(
                builder: (context, state) {
                  return buildDropdown<SubGroupModel>(
                    value: selectedSubCategory,
                    hint: widget.item.subGroupName,
                    green: green,
                    items: state.items,
                    displayText: (item) => item.arName,
                    onChanged: (val) =>
                        setState(() => selectedSubCategory = val),
                  );
                },
              ),
            ),
            Divider(color: Color(0xff868686), thickness: 1.5),
            
            // المحافظة
            buildRowLabelField(
              "المحافظة",
              BlocBuilder<GovernmentBloc, BaseState<Government>>(
                builder: (context, state) {
                  return buildDropdown<Government>(
                    value: selectedGovernorate,
                    items: state.items,
                    displayText: (item) => item.arName,
                    onChanged: (val) {
                      setState(() => selectedGovernorate = val);
                      context.read<SubAreaBloc>().getSubArea(val!.id);
                    },
                    hint: widget.item.governorateName,
                    green: green,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Divider(color: Color(0xff868686), thickness: 1.5),
            ),
            
            // المنطقة
            buildRowLabelField(
              "المنطقة",
              BlocBuilder<SubAreaBloc, BaseState<SubAreaModel>>(
                builder: (context, state) {
                  return buildDropdown<SubAreaModel>(
                    value: selectedArea,
                    items: state.items,
                    displayText: (item) => item.arName,
                    onChanged: (val) => setState(() => selectedArea = val),
                    hint: widget.item.areaName,
                    green: green,
                  );
                },
              ),
            ),
            Divider(color: Color(0xff868686), thickness: 1.5),
            
            // صور الاعلان
            Align(
              alignment: Alignment.topRight,
              child: label('صور الاعلان', green),
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: [
                  // عرض الصور
                  if (_existingImageUrls.isNotEmpty ||
                      _selectedImages.isNotEmpty) ...[
                    SizedBox(
                      height: 150.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        addAutomaticKeepAlives: true,
                        itemCount:
                            _existingImageUrls.length + _selectedImages.length,
                        itemBuilder: (context, index) {
                          bool isExistingImage =
                              index < _existingImageUrls.length;
                          return Stack(
                            children: [
                              Container(
                                width: 200.w,
                                margin: EdgeInsets.only(
                                  left: 8.w,
                                  right: 8.w,
                                  bottom: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: isExistingImage
                                      ? Image.network(
                                          _existingImageUrls[index],
                                          width: 200.w,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey.shade200,
                                              child: Icon(
                                                Icons.broken_image,
                                                color: Colors.grey,
                                              ),
                                            );
                                          },
                                        )
                                      : Image.file(
                                          _selectedImages[index -
                                              _existingImageUrls.length],
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
                                  onTap: () {
                                    if (isExistingImage) {
                                      _removeExistingImage(index);
                                    } else {
                                      _removeNewImage(
                                        index - _existingImageUrls.length,
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 16,
                                    ),
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
                  
                  // أزرار إضافة الصور
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
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: 32.sp,
                                  color: green,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "الكاميرا",
                                  style: TextStyle(fontSize: 12.sp),
                                ),
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
                                Icon(
                                  Icons.photo_library_outlined,
                                  size: 32.sp,
                                  color: green,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "المعرض",
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "يمكنك إضافة حتى 8 صور (${_existingImageUrls.length + _selectedImages.length}/8)",
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            
            // وصف الاعلان
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
                controller: _descController,
                decoration: InputDecoration(
                  hintText: widget.item.description,
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            
            // زر التعديل
            BlocProvider(
              create: (context) => sl<UpdateAdvertisementCubit>(),
              child: SizedBox(
                width: double.infinity,
                height: 50.h,
                child: BlocConsumer<UpdateAdvertisementCubit,
                    BaseState<AdvertisementResponseModel>>(
                  listener: (context, state) {
                    if (state.isSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.white),
                              SizedBox(width: 12.w),
                              Text("تم التعديل على الاعلان بنجاح"),
                            ],
                          ),
                          backgroundColor: AppColors.mainAppColor,
                          duration: Duration(seconds: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: EdgeInsets.all(16),
                        ),
                      );
                      Navigator.pop(context);
                    }
                    if (state.isFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errorMessage.toString()),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return state.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () {
                              // التحقق من عدد الصور الكلي
                              int totalImages = _existingImageUrls.length +
                                  _selectedImages.length;
                              if (totalImages < 5) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "يجب اختيار على الاقل 5 صور",
                                    ),
                                    backgroundColor: Colors.orange,
                                  ),
                                );
                                return;
                              }

                              // إرسال البيانات
                              context
                                  .read<UpdateAdvertisementCubit>()
                                  .submitAd(
                                    UpdateAdvertisementModel(
                                      id: widget.item.id,
                                      name: _titleController.text.isNotEmpty
                                          ? _titleController.text.trim()
                                          : widget.item.name,
                                      phone: _phoneController.text.isNotEmpty
                                          ? _phoneController.text.trim()
                                          : widget.item.phone,
                                      groupId: selectedCategory?.id ??
                                          widget.item.groupId,
                                      serviceId: selectedService?.id ??
                                          widget.item.serviceId,
                                      areaId: selectedArea?.id ??
                                          widget.item.areaId,
                                      subGroup: selectedSubCategory?.id ??
                                          widget.item.subGroupId,
                                      condtion: selectedCondition?.name ??
                                          widget.item.condition,
                                      price: _priceController.text.isNotEmpty
                                          ? double.tryParse(
                                                  _priceController.text
                                                      .trim()) ??
                                              widget.item.price.toDouble()
                                          : widget.item.price.toDouble(),
                                      isCloseReplies: isReplyClosed ??
                                          widget.item.isCloseReplies,
                                      currencyId: selectedCurrency?.id ??
                                          widget.item.currencyId,
                                      governorateId:
                                          selectedGovernorate?.id ??
                                              widget.item.governorateId,
                                      description:
                                          _descController.text.isNotEmpty
                                              ? _descController.text.trim()
                                              : widget.item.description,
                                      imagesToAdd: _selectedImages
                                          .map((e) => e.path)
                                          .toList(),
                                      imagesToDelete: _imagesToDelete,
                                    ),
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: green,
                            ),
                            child: Text(
                              "تعديل الاعلان",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget بناء صف يحتوي على Label و Field
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

  // Widget للـ Label
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

  // Widget للـ TextField
  Widget textField({
    String? hint,
    TextInputType? inputType,
    required Color green,
    required TextEditingController controller,
    List<TextInputFormatter>? inputFormatters,
  }) =>
      TextFormField(
        controller: controller,
        keyboardType: inputType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hint ?? '',
          contentPadding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: green),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      );

  // Widget للـ Dropdown
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
      items: items
          .map(
            (item) => DropdownMenuItem<T>(
              value: item,
              child: Text(displayText(item)),
            ),
          )
          .toList(),
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

  // تحويل حالة الإعلان للعربية
  String conditionArabic(String? condition) {
    switch (condition) {
      case 'New':
        return 'جديد';
      case 'Used':
        return 'مستخدم';
      case 'refurbished':
        return 'مجدد';
      default:
        return condition ?? '';
    }
  }
}