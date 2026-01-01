import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/data/model/sub_area_model.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/data/model/sub_group_model.dart';
import 'package:lahijcenter/Feature/Home/update_advertisement/data/models/advertisement_responce.dart';
import 'package:lahijcenter/core/utils/services/services_locator.dart';

import '../../../../../core/bloc/base_state.dart';
import '../../../../AddAdvertisement/data/model/currency.dart';
import '../../../../AddAdvertisement/data/model/government_model.dart';
import '../../../../AddAdvertisement/data/model/group.dart';
import '../../../../AddAdvertisement/data/model/services.dart';
import '../../../Data/model/item_model.dart' as ItemModels;
import '../manager/update_cubit.dart';
import '../widgets/edit_ad_description_field.dart';
import '../widgets/edit_ad_dropdowns.dart';
import '../widgets/edit_ad_form_fields.dart';
import '../widgets/edit_ad_image_picker.dart';
import '../widgets/edit_ad_reply_settings.dart';
import '../widgets/edit_ad_submit_button.dart';

class EdittAdvertisementScreen extends StatefulWidget {
  final ItemModels.Item item;

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

  final List<File> _selectedImages = [];
  final List<String> _existingImageUrls = [];
  final List<int> _imagesToDelete = [];
  List<ItemModels.AdvertisementImage>? _originalImages;

  final ImagePicker _picker = ImagePicker();
  final int _maxImages = 8;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isReplyClosed = widget.item.isCloseReplies;

    if (widget.item.advertisementImages != null &&
        widget.item.advertisementImages!.isNotEmpty) {
      _originalImages = List.from(widget.item.advertisementImages!);
      for (var img in widget.item.advertisementImages!) {
        _existingImageUrls.add(img.imageName);
      }
    }

    // Add listeners to controllers to rebuild when text changes
    _titleController.addListener(() => setState(() {}));
    _priceController.addListener(() => setState(() {}));
    _phoneController.addListener(() => setState(() {}));
    _descController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

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

  void _removeExistingImage(int index) {
    if (_originalImages != null && index < _originalImages!.length) {
      setState(() {
        final imageId = _originalImages![index].id;
        _imagesToDelete.add(imageId);
        _existingImageUrls.removeAt(index);
        _originalImages!.removeAt(index);
      });
    }
  }

  void _removeNewImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _showMaxImagesMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("لقد وصلت للحد الأقصى من الصور ($_maxImages صور)"),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color green = Colors.green;

    return BlocProvider(
      create: (context) => sl<UpdateAdvertisementCubit>(),
      child:
          BlocBuilder<
            UpdateAdvertisementCubit,
            BaseState<AdvertisementResponseModel>
          >(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text(
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
                body: AbsorbPointer(
                  absorbing: state.isLoading,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EditAdFormFields(
                          titleController: _titleController,
                          phoneController: _phoneController,
                          priceController: _priceController,
                          item: widget.item,
                          green: green,
                        ),
                        EditAdDropdowns(
                          item: widget.item,
                          green: green,
                          selectedCondition: selectedCondition,
                          selectedService: selectedService,
                          selectedCurrency: selectedCurrency,
                          selectedCategory: selectedCategory,
                          selectedSubCategory: selectedSubCategory,
                          selectedGovernorate: selectedGovernorate,
                          selectedArea: selectedArea,
                          onConditionChanged: (val) =>
                              setState(() => selectedCondition = val),
                          onServiceChanged: (val) =>
                              setState(() => selectedService = val),
                          onCurrencyChanged: (val) =>
                              setState(() => selectedCurrency = val),
                          onCategoryChanged: (val) =>
                              setState(() => selectedCategory = val),
                          onSubCategoryChanged: (val) =>
                              setState(() => selectedSubCategory = val),
                          onGovernorateChanged: (val) =>
                              setState(() => selectedGovernorate = val),
                          onAreaChanged: (val) =>
                              setState(() => selectedArea = val),
                        ),
                        EditAdReplySettings(
                          isReplyClosed: isReplyClosed,
                          onChanged: (value) =>
                              setState(() => isReplyClosed = value),
                          green: green,
                        ),
                        EditAdImagePicker(
                          existingImageUrls: _existingImageUrls,
                          selectedImages: _selectedImages,
                          maxImages: _maxImages,
                          green: green,
                          onPickCamera: pickImageFromCamera,
                          onPickGallery: pickImageFromGallery,
                          onRemoveExisting: _removeExistingImage,
                          onRemoveNew: _removeNewImage,
                        ),
                        SizedBox(height: 12.h),
                        EditAdDescriptionField(
                          controller: _descController,
                          item: widget.item,
                          green: green,
                        ),
                        SizedBox(height: 24.h),
                        EditAdSubmitButton(
                          item: widget.item,
                          titleController: _titleController,
                          phoneController: _phoneController,
                          priceController: _priceController,
                          descController: _descController,
                          selectedCondition: selectedCondition,
                          selectedService: selectedService,
                          selectedCurrency: selectedCurrency,
                          selectedCategory: selectedCategory,
                          selectedSubCategory: selectedSubCategory,
                          selectedGovernorate: selectedGovernorate,
                          selectedArea: selectedArea,
                          isReplyClosed: isReplyClosed,
                          existingImageUrls: _existingImageUrls,
                          imagesToAdd: _selectedImages
                              .map((e) => e.path)
                              .toList(),
                          imagesToDelete: _imagesToDelete,
                          green: green,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}
