import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/network/local/hive_crud_manager.dart';
import '../../../../core/sharde/widget/default_button.dart';
import '../../../Home/Data/model/categories.dart';
import '../../../Home/Data/model/item_model.dart';
import '../../data/model/government_model.dart';
import '../../data/model/services.dart';
import '../../data/model/currency.dart';
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

  String? selectedGovernorate;
  String? category;
  String selectedCloseReplies = 'لا';
  String? selectedServices;

  // Currency
  String? selectedCurrency;
  String selectedCurrencyArabic = '';
  String selectedCurrencyEnglish = '';
  String selectedCurrencyId = '';

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
  late Future<List<ModelCurrency>> currencyListFuture;

  @override
  void initState() {
    super.initState();

    selectedServicesArabic = widget.item.serviceName;
    selectedServicesEnglish = widget.item.serviceEName;
    selectedServicesId = widget.item.serviceId.toString();

    selectedCurrencyArabic = widget.item.currencyName;
    selectedCurrencyEnglish = widget.item.currencyEName;
    selectedCurrencyId = widget.item.currencyId.toString();

    nameofadd.text = widget.item.name;
    priceController.text = widget.item.price.toString();
    selectedCloseReplies = widget.item.isCloseReplies ? 'نعم' : 'لا';

    selectedCategoryArabic = widget.item.groupName;
    selectedCategoryEnglish = widget.item.groupEName;
    selectedCategoryId = widget.item.groupId.toString();

    selectedGovernorateArabic = widget.item.area;
    selectedGovernorateEnglish = widget.item.area;

   
  
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
                    categorylistfuture: categorylistfuture,
                    governmentListFuture: governmentListFuture,
                    servicesListFuture: servicesListFuture,
                    currencyListFuture: currencyListFuture,
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
                          // مكان تنفيذ عملية التحديث
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