import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import '../../../../../../../core/constans/app_colors.dart';
import '../../../../../../../core/constans/responsve_font.dart';
import '../../../../../../../core/sharde/widget/default_button.dart';
import '../../../../core/constans/fonts.dart';
import '../../../../core/network/local/hive_crud_manager.dart';
import '../../../Home/Data/model/categories.dart';
import '../../data/model/government_model.dart';
import '../../data/model/services.dart';
import '../../data/model/currency.dart';
import '../../manger/addadvertisminte_cubit.dart';
import '../widget/comment_section.dart';
import '../widget/custom_ad_field.dart';
import '../widget/image_card.dart';
import '../widget/nameadd_mobilewidget.dart';
import '../widget/pricecategory.dart';

class AddAdvertisementScreen extends StatefulWidget {
  const AddAdvertisementScreen({super.key});
  @override
  State<AddAdvertisementScreen> createState() => _AddAdvertisementScreenState();
}

class _AddAdvertisementScreenState extends State<AddAdvertisementScreen> {
  final TextEditingController nameofadd = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController comment = TextEditingController();
  TextEditingController ereacontroller=TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoadingServices = false;
  bool _isLoadingGovernment = false;
  bool _isLoadingCurrency = false;

  String? selectedGovernorate;
  String? category;
  String selectedCloseReplies = 'لا';
  String? selectedServices;
  String? selectedCurrency;

  String selectedCategoryArabic = '';
  String selectedCategoryEnglish = '';
  String selectedCategoryId = '';

  String selectedGovernorateArabic = '';
  String selectedGovernorateEnglish = '';
  String selectedGovernorateId = '';

  String selectedServicesArabic = '';
  String selectedServicesEnglish = '';
  String selectedServicesId = '';

  String selectedCurrencyArabic = '';
  String selectedCurrencyEnglish = '';
  String selectedCurrencyId = '';

  late Future<List<Government>> governmentListFuture;
  late Future<List<Categorygroups>> categorylistfuture;
  late Future<List<Services>> servicesListFuture;
  late Future<List<ModelCurrency>> currencyListFuture;

  @override
  void initState() {
    super.initState();
    governmentListFuture = loadGovernmentFromHive();
    categorylistfuture = loadCattegoryyFromHive();
    currencyListFuture = loadCurrencyFromHive();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = GetIt.instance<AddadvertisminteCubit>();

      if (cubit.services.isEmpty && !_isLoadingServices) {
        _isLoadingServices = true;
        cubit.fetchServices();
      }

      if (cubit.government.isEmpty && !_isLoadingGovernment) {
        _isLoadingGovernment = true;
        cubit.fetchgovermnet();
      }

      if (cubit.currency.isEmpty && !_isLoadingCurrency) {
        _isLoadingCurrency = true;
        cubit.fetchcurrency();
      }
    });
  }

  Future<List<Government>> loadGovernmentFromHive() async {
    final rawData = await HiveCrudManager.readList(
      "shared_data_box",
      "government",
    );
    if (rawData == null) return [];
    return rawData.map((e) => Government.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<Categorygroups>> loadCattegoryyFromHive() async {
    final rawData = await HiveCrudManager.readList(
      "shared_data_box",
      "category",
    );
    if (rawData == null) return [];
    return rawData.map((e) => Categorygroups.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<Services>> loadServicesFromHive() async {
    final rawData = await HiveCrudManager.readList(
      "shared_data_box",
      "services",
    );
    if (rawData == null) return [];
    return rawData.map((e) => Services.fromJson(Map<String, dynamic>.from(jsonDecode(jsonEncode(e))))).toList();
  }

  Future<List<ModelCurrency>> loadCurrencyFromHive() async {
    final rawData = await HiveCrudManager.readList(
      "shared_data_box",
      "currency",
    );
    if (rawData == null) return [];
    return rawData.map((e) => ModelCurrency.fromJson(Map<String, dynamic>.from(jsonDecode(jsonEncode(e))))).toList();
  }

  Future<List<Services>> getServicesFromCubit(AddadvertisminteCubit cubit) async {
    if (cubit.services.isNotEmpty) {
      return cubit.services;
    } else {
      return await loadServicesFromHive();
    }
  }

  Future<List<ModelCurrency>> getCurrencyFromCubit(AddadvertisminteCubit cubit) async {
    if (cubit.currency.isNotEmpty) {
      return cubit.currency;
    } else {
      return await loadCurrencyFromHive();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<AddadvertisminteCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          toolbarHeight: 40.h,
          title: Text(
            "اضافه اعلان",
            style: TextStyle(
              fontFamily: Fonts.font,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: getFontSize(context, 15),
            ),
          ),
          backgroundColor: AppColors.mainAppColor,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NameaddMobilewidget(
                    name: nameofadd,
                    phoneController: phoneController,
                  ),
                  BlocBuilder<AddadvertisminteCubit, AddadvertisminteState>(
                    builder: (context, state) {
                      final cubit = context.read<AddadvertisminteCubit>();
                      return Column(
                        children: [
                          FutureBuilder<List<ModelCurrency>>(
                            future: getCurrencyFromCubit(cubit),
                            builder: (context, snapshot) {
                              final currencyList = snapshot.data ?? [];
                              return PriceCategory(
                                priceController: priceController,
                                categorylistfuture: categorylistfuture,
                                governmentListFuture: governmentListFuture,
                                servicesListFuture: getServicesFromCubit(cubit),
                                currencyListFuture: getCurrencyFromCubit(cubit),
                                selectedGovernorate: selectedGovernorate,
                                selectedServices: selectedServices,
                                selectedCloseReplies: selectedCloseReplies,
                                category: category,
                                selectedCurrency: selectedCurrency,
                                onGovernorateChanged: (val) => setState(() => selectedGovernorate = val),
                                onServicesChanged: (val) => setState(() => selectedServices = val),
                                onCloseRepliesChanged: (val) => setState(() => selectedCloseReplies = val ?? 'لا'),
                                onCategoryChanged: (val) => setState(() => category = val),
                                onCurrencyChanged: (val) => setState(() => selectedCurrency = val),
                                onGovernorateSelected: (ar, en, id) {
                                  setState(() {
                                    selectedGovernorateArabic = ar;
                                    selectedGovernorateEnglish = en;
                                    selectedGovernorateId = id;
                                  });
                                },
                                onServicesSelected: (ar, en, id) {
                                  setState(() {
                                    selectedServicesArabic = ar;
                                    selectedServicesEnglish = en;
                                    selectedServicesId = id;
                                  });
                                },
                                onCategorySelected: (ar, en, id) {
                                  setState(() {
                                    selectedCategoryArabic = ar;
                                    selectedCategoryEnglish = en;
                                    selectedCategoryId = id;
                                  });
                                },
                                onCurrencySelected: (ar, en, id) {
                                  setState(() {
                                    selectedCurrencyArabic = ar;
                                    selectedCurrencyEnglish = en;
                                    selectedCurrencyId = id;
                                  });
                                },
                                selectedCategoryArabic: selectedCategoryArabic,
                                selectedCategoryEnglish: selectedCategoryEnglish,
                                selectedCategoryId: selectedCategoryId,
                                selectedGovernorateArabic: selectedGovernorateArabic,
                                selectedGovernorateEnglish: selectedGovernorateEnglish,
                                selectedGovernorateId: selectedGovernorateId,
                                selectedServicesArabic: selectedServicesArabic,
                                selectedServicesEnglish: selectedServicesEnglish,
                                selectedServicesId: selectedServicesId,
                                selectedCurrencyArabic: selectedCurrencyArabic,
                                selectedCurrencyEnglish: selectedCurrencyEnglish,
                                selectedCurrencyId: selectedCurrencyId,
                              );
                            },
                          ),
                          CustomAdField(

                            label: "المنطقه",
                            hintText: "اضف اسم المنطقه",
                            validationMessage: 'برجاء كتابه اسم المنطقه',
                            controller: ereacontroller,
                            validator: (value) {
                              debugPrint("Name Validator: value='$value'");
                              if (value == null || value.trim().isEmpty) {
                                debugPrint("Name validation failed: Field is empty");
                                return 'برجاء كتابه اسم المنطقه';
                              }
                              if (value.trim().length < 3) {
                                debugPrint("Name validation failed: Name too short");
                                return 'اسم الاعلان يجب أن يكون 3 أحرف على الأقل';
                              }
                              return null;
                            },
                          ),
                          const ImageCard(),
                          const Divider(thickness: 1, color: Color(0xff868686)),
                          CommentSectionrrSW(comment: comment),
                          BlocListener<AddadvertisminteCubit, AddadvertisminteState>(
                            listener: (context, state) {
                              if (state is AddadvertisminteprocessSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("تم إضافة الإعلان بنجاح"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Navigator.pop(context);
                              } else if (state is AddadvertisminteFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("فشل في إضافة الإعلان: ${state.message}"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            child: BlocBuilder<AddadvertisminteCubit, AddadvertisminteState>(
                              builder:(context,state) {

                             return  DefaultButton(
                               text: "اضافة الاعلان",

                               function: () async {
                                 if (_formKey.currentState!.validate()) {
                                   final cubit = context.read<AddadvertisminteCubit>();
                                   await cubit.addAdvertisement(
                                     name: nameofadd.text.trim(),
                                     phone: phoneController.text.trim(),
                                     groupId: int.tryParse(selectedCategoryId) ?? 0,
                                     serviceId: int.tryParse(selectedServicesId) ?? 0,
                                     price: double.tryParse(priceController.text.trim()) ?? 0.0,
                                     isCloseReplies: selectedCloseReplies == 'نعم',
                                     currencyId: int.tryParse(selectedCurrencyId) ?? 0,
                                     governorateId: int.tryParse(selectedGovernorateId) ?? 0,
                                     area: ereacontroller.text.trim(),
                                     description: comment.text.trim(),

                                   );
                                 }
                               },
                             );


                              } ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}