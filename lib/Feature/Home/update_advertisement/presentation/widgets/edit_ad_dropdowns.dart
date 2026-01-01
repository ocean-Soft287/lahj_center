import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/sub_area_bloc/sub_area_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/sub_catagory_bloc/sub_catagory_cubit.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/data/model/sub_area_model.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/data/model/sub_group_model.dart';
import '../../../../../core/bloc/base_state.dart';
import '../../../../AddAdvertisement/blocs/category_bloc/category_bloc.dart';
import '../../../../AddAdvertisement/blocs/currency_bloc/currency_bloc.dart';
import '../../../../AddAdvertisement/blocs/government_bloc/government_bloc.dart';
import '../../../../AddAdvertisement/blocs/services_bloc/services_bloc.dart';
import '../../../../AddAdvertisement/data/model/currency.dart';
import '../../../../AddAdvertisement/data/model/government_model.dart';
import '../../../../AddAdvertisement/data/model/group.dart';
import '../../../../AddAdvertisement/data/model/services.dart';
import '../../../Data/model/item_model.dart' as ItemModels;

// Enum for Conditions if not already defined globally or imported
enum AdCondition { New, Used, refurbished }

extension AdConditionExtension on AdCondition {
  String get arabicName {
    switch (this) {
      case AdCondition.New:
        return 'جديد';
      case AdCondition.Used:
        return 'مستخدم';
      case AdCondition.refurbished:
        return 'مجدد';
    }
  }
}

class EditAdDropdowns extends StatelessWidget {
  final ItemModels.Item item;
  final Color green;
  final AdCondition? selectedCondition;
  final Services? selectedService;
  final ModelCurrency? selectedCurrency;
  final Group? selectedCategory;
  final SubGroupModel? selectedSubCategory;
  final Government? selectedGovernorate;
  final SubAreaModel? selectedArea;

  final Function(AdCondition?) onConditionChanged;
  final Function(Services?) onServiceChanged;
  final Function(ModelCurrency?) onCurrencyChanged;
  final Function(Group?) onCategoryChanged;
  final Function(SubGroupModel?) onSubCategoryChanged;
  final Function(Government?) onGovernorateChanged;
  final Function(SubAreaModel?) onAreaChanged;

  const EditAdDropdowns({
    super.key,
    required this.item,
    required this.green,
    this.selectedCondition,
    this.selectedService,
    this.selectedCurrency,
    this.selectedCategory,
    this.selectedSubCategory,
    this.selectedGovernorate,
    this.selectedArea,
    required this.onConditionChanged,
    required this.onServiceChanged,
    required this.onCurrencyChanged,
    required this.onCategoryChanged,
    required this.onSubCategoryChanged,
    required this.onGovernorateChanged,
    required this.onAreaChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // حالة الإعلان
        buildRowLabelField(
          "حالة الإعلان",
          buildDropdown<AdCondition>(
            value: selectedCondition,
            items: AdCondition.values,
            displayText: (item) => item.arabicName,
            onChanged: onConditionChanged,
            hint: conditionArabic(item.condition),
            green: green,
          ),
        ),
        const Divider(color: Color(0xff868686), thickness: 1.5),

        // الخدمة
        buildRowLabelField(
          "الخدمة",
          BlocBuilder<ServicesBloc, BaseState<Services>>(
            builder: (context, state) {
              return buildDropdown<Services>(
                value: selectedService,
                items: state.items,
                displayText: (item) => item.name,
                onChanged: onServiceChanged,
                hint: item.serviceName,
                green: green,
              );
            },
          ),
        ),
        const Divider(color: Color(0xff868686), thickness: 1.5),

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
                    onChanged: onCurrencyChanged,
                    hint: item.currencyName,
                    green: green,
                  );
                },
              ),
            ),
          ],
        ),
        const Divider(color: Color(0xff868686), thickness: 1.5),

        // القسم الرئيسي
        buildRowLabelField(
          "القسم الرئيسي",
          BlocBuilder<CategoryBloc, BaseState<Group>>(
            builder: (context, state) {
              return buildDropdown<Group>(
                hint: item.groupName,
                green: green,
                value: selectedCategory,
                items: state.items,
                displayText: (item) => item.arName,
                onChanged: (val) {
                  onCategoryChanged(val);
                  if (val != null) {
                    context.read<SubCatagoryCubit>().getSubCatagory(val.id);
                  }
                },
              );
            },
          ),
        ),
        SizedBox(height: 12.h),
        const Padding(
          padding: EdgeInsets.only(right: 20, left: 20),
          child: Divider(color: Color(0xff868686), thickness: 1.5),
        ),

        // القسم الفرعي
        buildRowLabelField(
          "القسم الفرعي",
          BlocBuilder<SubCatagoryCubit, BaseState<SubGroupModel>>(
            builder: (context, state) {
              return buildDropdown<SubGroupModel>(
                value: selectedSubCategory,
                hint: item.subGroupName,
                green: green,
                items: state.items,
                displayText: (item) => item.arName,
                onChanged: onSubCategoryChanged,
              );
            },
          ),
        ),
        const Divider(color: Color(0xff868686), thickness: 1.5),

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
                  onGovernorateChanged(val);
                  if (val != null) {
                    context.read<SubAreaBloc>().getSubArea(val.id);
                  }
                },
                hint: item.governorateName,
                green: green,
              );
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 20, left: 20),
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
                onChanged: onAreaChanged,
                hint: item.areaName,
                green: green,
              );
            },
          ),
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
