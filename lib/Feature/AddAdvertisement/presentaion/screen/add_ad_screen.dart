import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/core/network/local/flutter_secure_storage.dart';
import '../../../../../../../core/constans/app_colors.dart';
import '../../../../../../../core/constans/responsve_font.dart';
import '../../../../../../../core/sharde/widget/default_button.dart';
import '../../../../core/constans/fonts.dart';
import '../../../../core/network/local/hive_crud_manager.dart';
import '../../../Home/Data/model/categories.dart';
import '../../data/model/government_model.dart';
import '../../data/model/services.dart';
import '../../manger/addadvertisminte_cubit.dart';
import '../widget/comment_section.dart';
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
  final _formKey = GlobalKey<FormState>();

  // Add flags to prevent multiple API calls
  bool _isLoadingServices = false;
  bool _isLoadingGovernment = false;

  String? selectedGovernorate;
  String? category;
  String selectedCloseReplies = 'لا';
  String? selectedServices;

  String selectedCategoryArabic = '';
  String selectedCategoryEnglish = '';
  String selectedCategoryId = '';

  String selectedGovernorateArabic = '';
  String selectedGovernorateEnglish = '';
  String selectedGovernorateId = '';

  String selectedServicesArabic = '';
  String selectedServicesEnglish = '';
  String selectedServicesId = '';

  late Future<List<Government>> governmentListFuture;
  late Future<List<Categorygroups>> categorylistfuture;
  late Future<List<Services>> servicesListFuture;

  @override
  void initState() {
    super.initState();
    governmentListFuture = loadGovernmentFromHive();
    categorylistfuture = loadCattegoryyFromHive();

    // Delay API calls to avoid blocking UI
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = GetIt.instance<AddadvertisminteCubit>();

      // Fetch services if not already loaded
      if (cubit.services.isEmpty && !_isLoadingServices) {
        _isLoadingServices = true;
        cubit.fetchServices();
      }

      // Fetch government if not already loaded
      if (cubit.government.isEmpty && !_isLoadingGovernment) {
        _isLoadingGovernment = true;
        cubit.fetchgovermnet();
      }
    });
  }

  Future<List<Government>> loadGovernmentFromHive() async {
    final rawData = await HiveCrudManager.readList(
      "shared_data_box",
      "government",
    );
    if (rawData == null) {
      return [];
    }
    return rawData
        .map((e) => Government.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Categorygroups>> loadCattegoryyFromHive() async {
    final rawData = await HiveCrudManager.readList(
      "shared_data_box",
      "category",
    );
    if (rawData == null) {
      return [];
    }
    return rawData
        .map((e) => Categorygroups.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Services>> loadServicesFromHive() async {
    final rawData = await HiveCrudManager.readList(
      "shared_data_box",
      "services",
    );
    if (rawData == null) {
      return [];
    }
    return rawData
        .map((e) => Services.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Services>> getServicesFromCubit(
    AddadvertisminteCubit cubit,
  ) async {

    if (cubit.services.isNotEmpty) {
      return cubit.services;
    } else {
      return await loadServicesFromHive();
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
                      AddadvertisminteCubit addadvertisminteCubit =
                          BlocProvider.of(context);



                      return Column(
                        children: [
                          PriceCategory(
                            priceController: priceController,
                            categorylistfuture: categorylistfuture,
                            governmentListFuture: governmentListFuture,
                            servicesListFuture: getServicesFromCubit(
                              addadvertisminteCubit,
                            ),
                            selectedGovernorate: selectedGovernorate,
                            selectedServices: selectedServices,
                            selectedCloseReplies: selectedCloseReplies,
                            category: category,
                            onGovernorateChanged: (val) =>
                                setState(() => selectedGovernorate = val),
                            onServicesChanged: (val) =>
                                setState(() => selectedServices = val),
                            onCloseRepliesChanged: (val) => setState(
                              () => selectedCloseReplies = val ?? 'لا',
                            ),
                            onCategoryChanged: (val) =>
                                setState(() => category = val),
                            onGovernorateSelected: (ar, en, id) => setState(() {
                              selectedGovernorateArabic = ar;
                              selectedGovernorateEnglish = en;
                              selectedGovernorateId = id;
                            }),
                            onServicesSelected: (ar, en, id) => setState(() {
                              selectedServicesArabic = ar;
                              selectedServicesEnglish = en;
                              selectedServicesId = id;
                            }),
                            onCategorySelected: (ar, en, id) => setState(() {
                              selectedCategoryArabic = ar;
                              selectedCategoryEnglish = en;
                              selectedCategoryId = id;
                            }),
                            selectedCategoryArabic: selectedCategoryArabic,
                            selectedCategoryEnglish: selectedCategoryEnglish,
                            selectedCategoryId: selectedCategoryId,
                            selectedGovernorateArabic:
                                selectedGovernorateArabic,
                            selectedGovernorateEnglish:
                                selectedGovernorateEnglish,
                            selectedGovernorateId: selectedGovernorateId,
                            selectedServicesArabic: selectedServicesArabic,
                            selectedServicesEnglish: selectedServicesEnglish,
                            selectedServicesId: selectedServicesId,
                          ),
                          const ImageCard(),
                          const Divider(thickness: 1, color: Color(0xff868686)),
                          CommentSectionrrSW(comment: comment),
                          DefaultButton(
                            text: "اضافة الاعلان",
                            function: () async {
                              debugPrint(
                                "الاسم قبل الفاليديشن: ${nameofadd.text}",
                              );
                              debugPrint(
                                "الهاتف قبل الفاليديشن: ${phoneController.text}",
                              );

                              final username =
                                  await SecureStorageService.read(
                                    SecureStorageService.name,
                                  ) ??
                                  '';
                              final id1String = await SecureStorageService.read(
                                SecureStorageService.customerid,
                              );
                              final id1 = int.tryParse(id1String ?? '0');

                              final parsedCategoryId =
                                  int.tryParse(selectedCategoryId) ?? 0;
                              final parsedGovernorateId =
                                  int.tryParse(selectedGovernorateId) ?? 0;
                              final parsedServicesId =
                                  int.tryParse(selectedServicesId) ?? 0;


                              if (addadvertisminteCubit.galleryImage.length <
                                  5) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "يجب رفع على الأقل 5 صور للإعلان",
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }


                              if (addadvertisminteCubit.galleryImage.length >
                                  8) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("مسموح بحد أقصى 8 صور فقط"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }


                              if (_formKey.currentState!.validate()) {
                                addadvertisminteCubit.addAdvertisement(
                                  id: id1 ?? 0,
                                  name: nameofadd.text,
                                  phone: phoneController.text,
                                  groupId: parsedCategoryId,
                                  groupName: selectedCategoryArabic,
                                  groupEName: selectedCategoryEnglish,
                                  serviceId: parsedServicesId,
                                  serviceName: selectedServicesArabic,
                                  serviceEName: selectedServicesEnglish,
                                  price:
                                      double.tryParse(priceController.text) ??
                                      0,
                                  currencyId: 0, // Removed currencyId
                                  currencyName: '', // Removed currencyName
                                  currencyEName: '', // Removed currencyEName
                                  regionId: parsedGovernorateId,
                                  regionName: selectedGovernorateArabic,
                                  regionEName: selectedGovernorateEnglish,
                                  area: selectedGovernorateArabic,
                                  description: comment.text,
                                  customerId: id1 ?? 0,
                                  customerName: username,
                                  customerEName: username,
                                  date: DateTime.now().toIso8601String(),
                                  isCloseReplies: selectedCloseReplies == "نعم",
                                  stateId: 4,
                                  stateName: "stateName",
                                  stateEName: "stateEName",
                                );
                              }
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  BlocListener<AddadvertisminteCubit, AddadvertisminteState>(
                    listener: (context, state) {
                      print('🎧 BlocListener - State: ${state.runtimeType}');

                      if (state is AddadvertisminteLoading) {

                      } else if (state is AddadvertisminteSuccess) {


                        if (state.data.isNotEmpty) {

                        }
                        // Reset loading flags when data is loaded
                        _isLoadingServices = false;
                        _isLoadingGovernment = false;
                      } else if (state is AddadvertisminteFailure) {

                        // Reset loading flags on failure
                        _isLoadingServices = false;
                        _isLoadingGovernment = false;
                      } else if (state is AddadvertisminteprocessSuccess) {

                      }

                      // ممكن تحط هنا أي رسالة نجاح مثلاً لو الإعلان تم إضافته بنجاح
                      if (state is AddadvertisminteprocessSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("تمت إضافة الإعلان بنجاح"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context);
                      } else if (state is AddadvertisminteFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
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
