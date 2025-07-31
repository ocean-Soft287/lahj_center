import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/network/local/hive_crud_manager.dart';
import '../../../../core/sharde/widget/default_button.dart';
import '../../../Home/Data/model/categories.dart';
import '../../../Home/Data/model/currency_model.dart';
import '../../../Home/Data/model/item_model.dart';
import '../../data/model/government_model.dart';
import '../../manger/addadvertisminte_cubit.dart';
import '../widget/comment_section.dart';
import '../widget/image_card_edit.dart';
import '../widget/nameadd_mobilewidget.dart';
import '../widget/pricecategory.dart';

class EditAdvertisementScreen extends StatefulWidget {
  const EditAdvertisementScreen({super.key, required this.item});
  final Item item;

  @override
  State<EditAdvertisementScreen> createState() => _EditAdvertisementScreenState();
}

class _EditAdvertisementScreenState extends State<EditAdvertisementScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameofadd = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController comment = TextEditingController();

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

    nameofadd.text = widget.item.name;
    // phoneController.text = widget.item.phone;
    priceController.text = widget.item.price.toString();
    // comment.text = widget.item.discription ?? '';

    selectedCloseReplies = widget.item.isCloseReplies ? 'نعم' : 'لا';

    selectedCategoryArabic = widget.item.groupName;
    selectedCategoryEnglish = widget.item.groupEName;
    selectedCategoryId = widget.item.groupId.toString();

    selectedCurrencyArabic = widget.item.currencyName;
    selectedCurrencyEnglish = widget.item.currencyEName;
    selectedCurrencyId = widget.item.currencyId.toString();

    selectedGovernorateArabic = widget.item.area;
    selectedGovernorateEnglish = widget.item.area;
    // selectedGovernorateId = widget.item.regionId.toString();
  }

  Future<List<Currency>> loadCurrencyFromHive() async {
    final rawData = await HiveCrudManager.readList("shared_data_box", "currency");
    if (rawData == null) return [];
    return rawData.map((e) => Currency.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<Categorygroups>> loadCattegoryyFromHive() async {
    final rawData = await HiveCrudManager.readList("shared_data_box", "category");
    if (rawData == null) return [];
    return rawData.map((e) => Categorygroups.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<Government>> loadGovernmentFromHive() async {
    final rawData = await HiveCrudManager.readList("shared_data_box", "government");
    if (rawData == null) return [];
    return rawData.map((e) => Government.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = GetIt.instance<AddadvertisminteCubit>();
        cubit.oldImage = (widget.item.advertisementImages ?? []).map((e) => e.imageName).toList();
        return cubit;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("تعديل الإعلان", style: TextStyle(color: Colors.white)),
          backgroundColor: AppColors.mainAppColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
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
                    onGovernorateChanged: (val) => setState(() => selectedGovernorate = val ?? ''),
                    onCurrencyChanged: (val) => setState(() => selectedCurrency = val ?? ''),
                    onCloseRepliesChanged: (val) => setState(() => selectedCloseReplies = val ?? ''),
                    onCategoryChanged: (val) => setState(() => category = val ?? ''),
                    onGovernorateSelected: (ar, en, id) => setState(() {
                      selectedGovernorateArabic = ar;
                      selectedGovernorateEnglish = en;
                      selectedGovernorateId = id;
                    }),
                    onCategorySelected: (ar, en, id) => setState(() {
                      selectedCategoryArabic = ar;
                      selectedCategoryEnglish = en;
                      selectedCategoryId = id;
                    }),
                    onCurrencySelected: (ar, en, id) => setState(() {
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
                  const ImageCardEdit(),
                  const Divider(thickness: 1, color: Color(0xff868686)),
                  CommentSectionrrSW(comment: comment),
                  BlocBuilder<AddadvertisminteCubit, AddadvertisminteState>(
                    builder: (context, state) {
                      final cubit = context.read<AddadvertisminteCubit>();
                      return DefaultButton(
                        text: "تحديث الإعلان",
                        function: () async {
                          // final id = widget.item.id;
                          // final customerId = widget.item.;
                          // final username = await SecureStorageService.read(SecureStorageService.name) ?? '';
                          //
                          // if (_formKey.currentState!.validate()) {
                          //   cubit.edit(
                          //     id: id,
                          //     name: nameofadd.text,
                          //     phone: phoneController.text,
                          //     groupId: int.tryParse(selectedCategoryId) ?? 0,
                          //     groupName: selectedCategoryArabic,
                          //     groupEName: selectedCategoryEnglish,
                          //     serviceId: int.tryParse(selectedCategoryId) ?? 0,
                          //     serviceName: selectedCategoryEnglish,
                          //     serviceEName: selectedCategoryArabic,
                          //     price: double.tryParse(priceController.text) ?? 0,
                          //     currencyId: int.tryParse(selectedCurrencyId) ?? 0,
                          //     currencyName: selectedCurrencyArabic,
                          //     currencyEName: selectedCurrencyEnglish,
                          //     regionId: int.tryParse(selectedGovernorateId) ?? 0,
                          //     regionName: selectedGovernorateArabic,
                          //     regionEName: selectedGovernorateEnglish,
                          //     area: selectedGovernorateArabic,
                          //     description: comment.text,
                          //     customerId: customerId,
                          //     customerName: username,
                          //     customerEName: username,
                          //     date: DateTime.now().toIso8601String(),
                          //     isCloseReplies: selectedCloseReplies == "نعم",
                          //     stateId: 4,
                          //     stateName: "stateName",
                          //     stateEName: "stateEName",
                          //   );
                          //   print(cubit.oldImage);
                          //   print(cubit.galleryImage.map((x) => File(x!.path)).toList(),);
                          // }
                        },
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