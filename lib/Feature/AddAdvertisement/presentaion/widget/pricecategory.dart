import 'package:flutter/material.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/fonts.dart';
import '../../../../core/constans/responsve_font.dart';
import '../../../../core/sharde/widget/text_forn_field.dart';
import '../../../Home/Data/model/categories.dart';
import '../../../Home/Data/model/currency_model.dart';
import '../../data/model/government_model.dart';
import '../../data/model/services.dart';
import 'custom_drop_down.dart';

class PriceCategory extends StatefulWidget {
  final TextEditingController priceController;
  final Future<List<Government>> governmentListFuture;
  final Future<List<Categorygroups>> categorylistfuture;
  final Future<List<Services>> servicesListFuture;

  final String? selectedGovernorate;
  final String? selectedServices;
  final String selectedCloseReplies;
  final String? category;

  final String selectedCategoryArabic;
  final String selectedCategoryEnglish;
  final String selectedCategoryId;

  final String selectedGovernorateArabic;
  final String selectedGovernorateEnglish;
  final String selectedGovernorateId;

  final String selectedServicesArabic;
  final String selectedServicesEnglish;
  final String selectedServicesId;

  final void Function(String?) onGovernorateChanged;
  final void Function(String?) onServicesChanged;
  final void Function(String?) onCloseRepliesChanged;
  final void Function(String?) onCategoryChanged;
  final void Function(String, String, String) onCategorySelected;
  final void Function(String, String, String) onGovernorateSelected;
  final void Function(String, String, String) onServicesSelected;

  const PriceCategory({
    super.key,
    required this.priceController,
    required this.governmentListFuture,
    required this.categorylistfuture,
    required this.servicesListFuture,
    required this.selectedGovernorate,
    required this.selectedServices,
    required this.selectedCloseReplies,
    required this.category,
    required this.onGovernorateChanged,
    required this.onServicesChanged,
    required this.onCloseRepliesChanged,
    required this.onCategoryChanged,
    required this.selectedCategoryArabic,
    required this.selectedCategoryEnglish,
    required this.selectedCategoryId,
    required this.selectedGovernorateArabic,
    required this.selectedGovernorateEnglish,
    required this.selectedGovernorateId,
    required this.selectedServicesArabic,
    required this.selectedServicesEnglish,
    required this.selectedServicesId,
    required this.onCategorySelected,
    required this.onGovernorateSelected,
    required this.onServicesSelected,
  });

  @override
  State<PriceCategory> createState() => _PriceCategoryState();
}

class _PriceCategoryState extends State<PriceCategory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // فئة الخدمة
        buildDropdown<Categorygroups>(
          label: "القسم الرئيسي",
          future: widget.categorylistfuture,
          selectedValue: widget.category,
          onChanged: (value) {
            if (value != null) {
              widget.categorylistfuture.then((items) {
                final item = items.firstWhere((e) => e.id.toString() == value);
                widget.onCategorySelected(
                  item.arName,
                  item.enName,
                  item.id.toString(),
                );
                widget.onCategoryChanged(value);
                setState(() {});
              });
            }
          },
          getId: (e) => e.id.toString(),
          getName: (e) => e.arName,
          getNameen: (e) => e.enName,
        ),
        const Divider(thickness: 1, color: Color(0xff868686)),

        // الخدمة
        buildDropdown<Services>(
          label: "الخدمة",
          future: widget.servicesListFuture,
          selectedValue: widget.selectedServices,
          onChanged: (value) {
            if (value != null) {
              widget.servicesListFuture.then((items) {
                final item = items.firstWhere((e) => e.id.toString() == value);
                widget.onServicesSelected(
                  item.name,
                  item.eName,
                  item.id.toString(),
                );
                widget.onServicesChanged(value);
                setState(() {});
              });
            }
          },
          getId: (e) => e.id.toString(),
          getName: (e) => e.name,
          getNameen: (e) => e.eName,
        ),
        const Divider(thickness: 1, color: Color(0xff868686)),

        // السعر
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "السعر",
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
                controller: widget.priceController,
                hintText: "0",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "برجاء كتابه قيمه المنتج";
                  }
                  final price = double.tryParse(value);
                  if (price == null || price <= 0) {
                    return "لا يمكن أن تكون قيمة المنتج صفر أو أقل";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const Divider(thickness: 1, color: Color(0xff868686)),

        // إغلاق الردود
        CustomDropdown(
          label: "اغلاق الردود",
          items: const ["لا", "نعم"],
          selectedValue: widget.selectedCloseReplies,
          onChanged: (value) {
            widget.onCloseRepliesChanged(value);
            setState(() {});
          },
        ),

        const Divider(thickness: 1, color: Color(0xff868686)),

        const Divider(thickness: 1, color: Color(0xff868686)),

        // المحافظة
        buildDropdown<Government>(
          label: "المحافظة",
          future: widget.governmentListFuture,
          selectedValue: widget.selectedGovernorate,
          onChanged: (value) {
            if (value != null) {
              widget.governmentListFuture.then((items) {
                final item = items.firstWhere((e) => e.id.toString() == value);
                widget.onGovernorateSelected(
                  item.arName,
                  item.enName,
                  item.id.toString(),
                );
                widget.onGovernorateChanged(value);
                setState(() {});
              });
            }
          },
          getId: (e) => e.id.toString(),
          getName: (e) => e.arName,
          getNameen: (e) => e.enName,
        ),

        const Divider(thickness: 1, color: Color(0xff868686)),
      ],
    );
  }

  Widget buildDropdown<T>({
    required String label,
    required Future<List<T>> future,
    required String? selectedValue,
    required void Function(String?) onChanged,
    required String Function(T) getId,
    required String Function(T) getName,
    required String Function(T) getNameen,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: Fonts.font,
            color: AppColors.mainAppColor,
            fontWeight: FontWeight.w500,
            fontSize: getFontSize(context, 16),
          ),
        ),
        FutureBuilder<List<T>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                width: MediaQuery.sizeOf(context).width * .6,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.mainAppColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "جاري التحميل...",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              return Container(
                width: MediaQuery.sizeOf(context).width * .6,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "خطأ في التحميل",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${snapshot.error}",
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ],
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container(
                width: MediaQuery.sizeOf(context).width * .6,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "لا توجد بيانات متاحة",
                  style: TextStyle(color: Colors.orange),
                ),
              );
            }

            final items = snapshot.data!;

            // Remove duplicates based on ID
            final uniqueItems = <String, T>{};
            for (final item in items) {
              final id = getId(item);
              if (!uniqueItems.containsKey(id)) {
                uniqueItems[id] = item;
              }
            }

            final uniqueItemsList = uniqueItems.values.toList();
            final itemIds = uniqueItemsList.map((e) => getId(e)).toList();

            // Check if selected value exists in unique items
            String? validSelectedValue;
            if (selectedValue != null && itemIds.contains(selectedValue)) {
              validSelectedValue = selectedValue;
            }

            return Container(
              width: MediaQuery.sizeOf(context).width * .6,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.mainAppColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: validSelectedValue,
                  hint: Text(label),
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  onChanged: (value) {
                    onChanged(value);
                    setState(() {});
                  },
                  items: uniqueItemsList.map((e) {
                    final id = getId(e);
                    return DropdownMenuItem<String>(
                      key: ValueKey(id), // Add unique key
                      value: id,
                      child: Text('${getName(e)} (${getNameen(e)})'),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
