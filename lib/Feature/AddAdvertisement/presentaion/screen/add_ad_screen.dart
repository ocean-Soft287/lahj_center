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
import '../../../Home/Data/model/currency_model.dart';
import '../../data/model/government_model.dart';
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

  String selectedGovernorate = '';
  String category = '';
  String selectedCurrency = '';
  String selectedCloseReplies = 'لا';

  String selectedCategoryArabic = '';
  String selectedCategoryEnglish = '';
  String selectedCategoryId = '';

  String selectedCurrencyArabic = '';
  String selectedCurrencyEnglish = '';
  String selectedCurrencyId = '';

  String selectedGovernorateArabic = '';
  String selectedGovernorateEnglish = '';
  String selectedGovernorateId = '';

  late Future<List<Currency>> currencyListFuture;
  late Future<List<Government>> governmentListFuture;
  late Future<List<Categorygroups>> categorylistfuture;

  @override
  void initState() {
    super.initState();
    currencyListFuture = loadCurrencyFromHive();
    governmentListFuture = loadGovernmentFromHive();
    categorylistfuture = loadCattegoryyFromHive();
  }

  Future<List<Currency>> loadCurrencyFromHive() async {
    final rawData = await HiveCrudManager.readList(
      "shared_data_box",
      "currency",
    );
    if (rawData == null) return [];
    return rawData
        .map((e) => Currency.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Categorygroups>> loadCattegoryyFromHive() async {
    final rawData = await HiveCrudManager.readList(
      "shared_data_box",
      "category",
    );
    if (rawData == null) return [];
    return rawData
        .map((e) => Categorygroups.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Government>> loadGovernmentFromHive() async {
    final rawData = await HiveCrudManager.readList(
      "shared_data_box",
      "government",
    );
    if (rawData == null) return [];
    return rawData
        .map((e) => Government.fromJson(e as Map<String, dynamic>))
        .toList();
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
                  PriceCategory(
                    priceController: priceController,
                    currencyListFuture: currencyListFuture,
                    categorylistfuture: categorylistfuture,
                    governmentListFuture: governmentListFuture,
                    selectedGovernorate: selectedGovernorate,
                    selectedCurrency: selectedCurrency,
                    selectedCloseReplies: selectedCloseReplies,
                    category: category,
                    onGovernorateChanged:
                        (val) =>
                            setState(() => selectedGovernorate = val ?? ''),
                    onCurrencyChanged:
                        (val) => setState(() => selectedCurrency = val ?? ''),
                    onCloseRepliesChanged:
                        (val) =>
                            setState(() => selectedCloseReplies = val ?? ''),
                    onCategoryChanged:
                        (val) => setState(() => category = val ?? ''),
                    onGovernorateSelected:
                        (ar, en, id) => setState(() {
                          selectedGovernorateArabic = ar;
                          selectedGovernorateEnglish = en;
                          selectedGovernorateId = id;
                        }),
                    onCategorySelected:
                        (ar, en, id) => setState(() {
                          selectedCategoryArabic = ar;
                          selectedCategoryEnglish = en;
                          selectedCategoryId = id;
                        }),
                    onCurrencySelected:
                        (ar, en, id) => setState(() {
                          selectedCurrencyArabic = ar;
                          selectedCurrencyEnglish = en;
                          selectedCurrencyId = id;
                        }),
                    selectedCategoryArabic: selectedCategoryArabic,
                    selectedCategoryEnglish: selectedCategoryEnglish,
                    selectedCategoryId: selectedCategoryId,
                    selectedCurrencyArabic: selectedCurrencyArabic,
                    selectedCurrencyEnglish: selectedCurrencyEnglish,
                    selectedCurrencyId: selectedCurrencyId,
                    selectedGovernorateArabic: selectedGovernorateArabic,
                    selectedGovernorateEnglish: selectedGovernorateEnglish,
                    selectedGovernorateId: selectedGovernorateId,
                  ),
                  const ImageCard(),
                  const Divider(thickness: 1, color: Color(0xff868686)),
                  CommentSectionrrSW(comment: comment),
                  BlocConsumer<AddadvertisminteCubit, AddadvertisminteState>(
                    builder: (context, state) {
                      AddadvertisminteCubit addadvertisminteCubit = BlocProvider.of(context);

                      return DefaultButton(
                        text: "اضافة الاعلان",
                        function: () async {
                          debugPrint("الاسم قبل الفاليديشن: ${nameofadd.text}");
                          debugPrint("الهاتف قبل الفاليديشن: ${phoneController.text}");

                          final username = await SecureStorageService.read(SecureStorageService.name) ?? '';
                          final id1String = await SecureStorageService.read(SecureStorageService.customerid);
                          final id1 = int.tryParse(id1String ?? '0');

                          final parsedCategoryId = int.tryParse(selectedCategoryId) ?? 0;
                          final parsedCurrencyId = int.tryParse(selectedCurrencyId) ?? 0;
                          final parsedGovernorateId = int.tryParse(selectedGovernorateId) ?? 0;

                          // ✅ الشرط الأول: عدد الصور لا يقل عن 5
                          if (addadvertisminteCubit.galleryImage.length < 5) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("يجب رفع على الأقل 5 صور للإعلان"),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          // ✅ الشرط الثاني: لا يزيد عن 8 صور
                          if (addadvertisminteCubit.galleryImage.length > 8) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("مسموح بحد أقصى 8 صور فقط"),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          // ✅ تنفيذ الإرسال لو النموذج Valid
                          if (_formKey.currentState!.validate()) {
                            addadvertisminteCubit.addAdvertisement(
                              id: id1 ?? 0,
                              name: nameofadd.text,
                              phone: phoneController.text,
                              groupId: parsedCategoryId,
                              groupName: selectedCategoryArabic,
                              groupEName: selectedCategoryEnglish,
                              serviceId: parsedCategoryId,
                              serviceName: selectedCategoryEnglish,
                              serviceEName: selectedCategoryArabic,
                              price: double.tryParse(priceController.text) ?? 0,
                              currencyId: parsedCurrencyId,
                              currencyName: selectedCurrencyArabic,
                              currencyEName: selectedCurrencyEnglish,
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
                      );
                    },
                    listener: (context, state) {
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
