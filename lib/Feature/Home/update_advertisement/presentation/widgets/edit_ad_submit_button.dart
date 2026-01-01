import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lahijcenter/Feature/Home/update_advertisement/data/models/advertisement_responce.dart';
import 'package:lahijcenter/Feature/Home/update_advertisement/data/models/update_advertisement_model.dart';
import 'package:lahijcenter/Feature/Home/update_advertisement/presentation/manager/update_cubit.dart';
import 'package:lahijcenter/Feature/Home/update_advertisement/presentation/widgets/edit_ad_dropdowns.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';
import 'package:lahijcenter/core/constans/app_colors.dart';
import '../../../../AddAdvertisement/data/model/currency.dart';
import '../../../../AddAdvertisement/data/model/government_model.dart';
import '../../../../AddAdvertisement/data/model/group.dart';
import '../../../../AddAdvertisement/data/model/services.dart';
import '../../../../AddAdvertisement/data/model/sub_area_model.dart';
import '../../../../AddAdvertisement/data/model/sub_group_model.dart';
import '../../../Data/model/item_model.dart' as ItemModels;

class EditAdSubmitButton extends StatelessWidget {
  final ItemModels.Item item;
  final TextEditingController titleController;
  final TextEditingController phoneController;
  final TextEditingController priceController;
  final TextEditingController descController;
  final AdCondition? selectedCondition;
  final Services? selectedService;
  final ModelCurrency? selectedCurrency;
  final Group? selectedCategory;
  final SubGroupModel? selectedSubCategory;
  final Government? selectedGovernorate;
  final SubAreaModel? selectedArea;
  final bool? isReplyClosed;
  final List<String> existingImageUrls;
  final List<String> imagesToAdd;
  final List<int> imagesToDelete;
  final Color green;

  const EditAdSubmitButton({
    super.key,
    required this.item,
    required this.titleController,
    required this.phoneController,
    required this.priceController,
    required this.descController,
    required this.selectedCondition,
    required this.selectedService,
    required this.selectedCurrency,
    required this.selectedCategory,
    required this.selectedSubCategory,
    required this.selectedGovernorate,
    required this.selectedArea,
    required this.isReplyClosed,
    required this.existingImageUrls,
    required this.imagesToAdd,
    required this.imagesToDelete,
    required this.green,
  });

  bool _hasChanges() {
    final bool nameChanged =
        titleController.text.trim().isNotEmpty &&
        titleController.text.trim() != item.name;
    final bool phoneChanged =
        phoneController.text.trim().isNotEmpty &&
        phoneController.text.trim() != item.phone;
    final bool priceChanged =
        priceController.text.trim().isNotEmpty &&
        (double.tryParse(priceController.text.trim()) ??
                item.price.toDouble()) !=
            item.price.toDouble();
    final bool descChanged =
        descController.text.trim().isNotEmpty &&
        descController.text.trim() != item.description;

    final bool conditionChanged =
        selectedCondition != null && selectedCondition!.name != item.condition;
    final bool serviceChanged =
        selectedService != null && selectedService!.id != item.serviceId;
    final bool currencyChanged =
        selectedCurrency != null && selectedCurrency!.id != item.currencyId;
    final bool categoryChanged =
        selectedCategory != null && selectedCategory!.id != item.groupId;
    final bool subCategoryChanged =
        selectedSubCategory != null &&
        selectedSubCategory!.id != item.subGroupId;
    final bool governorateChanged =
        selectedGovernorate != null &&
        selectedGovernorate!.id != item.governorateId;
    final bool areaChanged =
        selectedArea != null && selectedArea!.id != item.areaId;
    final bool repliesChanged =
        isReplyClosed != null && isReplyClosed != item.isCloseReplies;

    final bool imagesChanged =
        imagesToAdd.isNotEmpty || imagesToDelete.isNotEmpty;

    return nameChanged ||
        phoneChanged ||
        priceChanged ||
        descChanged ||
        conditionChanged ||
        serviceChanged ||
        currencyChanged ||
        categoryChanged ||
        subCategoryChanged ||
        governorateChanged ||
        areaChanged ||
        repliesChanged ||
        imagesChanged;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      UpdateAdvertisementCubit,
      BaseState<AdvertisementResponseModel>
    >(
      listener: (context, state) {
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 12.w),
                  const Text("تم التعديل على الاعلان بنجاح"),
                ],
              ),
              backgroundColor: AppColors.mainAppColor,
              duration: const Duration(seconds: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(16),
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
        final bool canSubmit = !state.isLoading && _hasChanges();

        return SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: canSubmit
                ? () {
                    // التحقق من عدد الصور الكلي
                    int totalImages =
                        existingImageUrls.length + imagesToAdd.length;
                    if (totalImages < 5) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("يجب اختيار على الاقل 5 صور"),
                          backgroundColor: Colors.orange,
                        ),
                      );
                      return;
                    }
                    // إرسال البيانات
                    context.read<UpdateAdvertisementCubit>().submitAd(
                      UpdateAdvertisementModel(
                        id: item.id,
                        name: titleController.text.isNotEmpty
                            ? titleController.text.trim()
                            : item.name,
                        phone: phoneController.text.isNotEmpty
                            ? phoneController.text.trim()
                            : item.phone,
                        groupId: selectedCategory?.id ?? item.groupId,
                        serviceId: selectedService?.id ?? item.serviceId,
                        areaId: selectedArea?.id ?? item.areaId,
                        subGroup: selectedSubCategory?.id ?? item.subGroupId,
                        condtion: selectedCondition?.name ?? item.condition,
                        price: priceController.text.isNotEmpty
                            ? double.tryParse(priceController.text.trim()) ??
                                  item.price.toDouble()
                            : item.price.toDouble(),
                        isCloseReplies: isReplyClosed ?? item.isCloseReplies,
                        currencyId: selectedCurrency?.id ?? item.currencyId,
                        governorateId:
                            selectedGovernorate?.id ?? item.governorateId,
                        description: descController.text.isNotEmpty
                            ? descController.text.trim()
                            : item.description,
                        imagesToAdd: imagesToAdd,
                        imagesToDelete: imagesToDelete,
                      ),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: canSubmit ? green : Colors.grey,
            ),
            child: state.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    "تعديل الاعلان",
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
          ),
        );
      },
    );
  }
}
