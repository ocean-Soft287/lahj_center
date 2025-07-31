import 'package:flutter/material.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/fonts.dart';
import '../../../../core/constans/responsve_font.dart';
import '../../../../core/sharde/widget/text_forn_field.dart';
import '../../../Home/Data/model/categories.dart';
import '../../../Home/Data/model/currency_model.dart';
import '../../data/model/government_model.dart';
import 'custom_drop_down.dart';


class PriceCategory extends StatefulWidget {
  final TextEditingController priceController;
  final Future<List<Currency>> currencyListFuture;
  final Future<List<Government>> governmentListFuture;
  final Future<List<Categorygroups>> categorylistfuture;

  final String selectedGovernorate;
  final String selectedCurrency;
  final String selectedCloseReplies;
  final String category;

  final String selectedCategoryArabic;
  final String selectedCategoryEnglish;
  final String selectedCategoryId;

  final String selectedCurrencyArabic;
  final String selectedCurrencyEnglish;
  final String selectedCurrencyId;

  final String selectedGovernorateArabic;
  final String selectedGovernorateEnglish;
  final String selectedGovernorateId;

  final void Function(String?) onGovernorateChanged;
  final void Function(String?) onCurrencyChanged;
  final void Function(String?) onCloseRepliesChanged;
  final void Function(String?) onCategoryChanged;
  final void Function(String, String, String) onCategorySelected;
  final void Function(String, String, String) onCurrencySelected;
  final void Function(String, String, String) onGovernorateSelected;

   const PriceCategory({
    super.key,
    required this.priceController,
    required this.currencyListFuture,
    required this.governmentListFuture,
    required this.categorylistfuture,
    required this.selectedGovernorate,
    required this.selectedCurrency,
    required this.selectedCloseReplies,
    required this.category,
    required this.onGovernorateChanged,
    required this.onCurrencyChanged,
    required this.onCloseRepliesChanged,
    required this.onCategoryChanged,
    required this.selectedCategoryArabic,
    required this.selectedCategoryEnglish,
    required this.selectedCategoryId,
    required this.selectedCurrencyArabic,
    required this.selectedCurrencyEnglish,
    required this.selectedCurrencyId,
    required this.selectedGovernorateArabic,
    required this.selectedGovernorateEnglish,
    required this.selectedGovernorateId,
    required this.onCategorySelected,
    required this.onCurrencySelected,
    required this.onGovernorateSelected,
  });

  @override
  State<PriceCategory> createState() => _PriceCategoryState();
}

class _PriceCategoryState extends State<PriceCategory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

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
              });
            }
          },
          getId: (e) => e.id.toString(),
          getName: (e) => e.arName,
          getNameen: (e) => e.enName,
        ),
        const Divider(thickness: 1, color: Color(0xff868686)),

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .29,
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

                  FutureBuilder<List<Currency>>(
                    future: widget.currencyListFuture,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return const CircularProgressIndicator();
                      final items = snapshot.data!;
                      return Container(
                        width: MediaQuery.sizeOf(context).width * .29,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.mainAppColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: widget.selectedCurrency.isNotEmpty ? widget.selectedCurrency : null,
                            hint: const Text("العملة"),
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                            onChanged: (value) {
                              if (value != null) {
                                widget.currencyListFuture.then((items) {
                                  final item = items.firstWhere((e) => e.currencyID.toString() == value);
                                  widget.onCurrencySelected(
                                    item.currencyName,
                                    item.currencyName, // Adjust if English name is different
                                    item.currencyID.toString(),
                                  );
                                  widget.onCurrencyChanged(value);
                                });
                              }
                            },
                            items: items.map((e) {
                              return DropdownMenuItem<String>(
                                value: e.currencyID.toString(),
                                child: Text(e.currencyName.toString()),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(thickness: 1, color: Color(0xff868686)),

        /// اغلاق الردود
        CustomDropdown(
          label: "اغلاق الردود",
          items: const ["لا", "نعم"],
          selectedValue: widget.selectedCloseReplies,
          onChanged: widget.onCloseRepliesChanged,
        ),

        /// المحافظة
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
    required String selectedValue,
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
            if (!snapshot.hasData) return const CircularProgressIndicator();
            final items = snapshot.data!;
            return Container(
              width: MediaQuery.sizeOf(context).width * .6,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.mainAppColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedValue.isNotEmpty ? selectedValue : null,
                  hint: Text(label),
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  onChanged: onChanged,
                  items: items.map((e) {
                    return DropdownMenuItem<String>(
                      value: getId(e),
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