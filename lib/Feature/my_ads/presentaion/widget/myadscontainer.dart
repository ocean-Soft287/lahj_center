import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/sub_area_bloc/sub_area_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/sub_catagory_bloc/sub_catagory_cubit.dart';
import 'package:lahijcenter/Feature/Home/update_advertisement/presentation/manager/delete_my_advertisement_cubit.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/sharde/widget/default_button.dart';
import '../../../../core/utils/services/services_locator.dart';
import '../../../AddAdvertisement/blocs/category_bloc/category_bloc.dart';
import '../../../AddAdvertisement/blocs/currency_bloc/currency_bloc.dart';
import '../../../AddAdvertisement/blocs/government_bloc/government_bloc.dart';
import '../../../AddAdvertisement/blocs/services_bloc/services_bloc.dart';
import '../../../Home/Data/model/item_model.dart';
import '../../../Home/update_advertisement/presentation/screens/edite_advertisement_screen.dart';

class Myadscontainer extends StatelessWidget {
  const Myadscontainer({super.key, required this.item, required this.function});

  final Item item;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100.w,
              height: 100.w,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: item.advertisementImages.isEmpty
                      ? Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[600],
                            size: 40.sp,
                          ),
                        )
                      : Image.network(
                          item.advertisementImages[0].imageName,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                ),
              ),
            ),

            SizedBox(width: 10.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: MainTitle(
                          text: item.name,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.mainAppColor,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainTitle(
                        icon: Icons.category,
                        text: item.serviceName,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.hintTextColor,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      MainTitle(
                        icon: Icons.location_on,
                        text: item.governorateEName,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.hintTextColor,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainTitle(
                        icon: Icons.attach_money,
                        text: item.price.toString(),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.hintTextColor,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      MainTitle(
                        icon: Icons.info,
                        text: item.condition,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.hintTextColor,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * .25,
              height: 35.h,
              child: DefaultButton(
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => sl<GovernmentBloc>(),
                          ),
                          BlocProvider(create: (context) => sl<ServicesBloc>()),
                          BlocProvider(create: (context) => sl<CurrencyBloc>()),
                          BlocProvider(create: (context) => sl<CategoryBloc>()),
                          BlocProvider(create: (context) => sl<SubAreaBloc>()),
                          BlocProvider(
                            create: (context) => sl<SubCatagoryCubit>(),
                          ),
                        ],
                        child: EdittAdvertisementScreen(item: item),
                      ),
                    ),
                  );
                },
                text: "تعديل",
              ),
            ),
            SizedBox(width: 10.w),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.25,
              height: 35.h,
              child: Builder(
                builder: (context) {
                  return DefaultButton(
                    text: "حذف",
                    function: () {
                      if (!context.mounted) return;

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          int selectedReason = 0;

                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                contentPadding: EdgeInsets.all(20.w),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (context.mounted)
                                            Navigator.pop(context);
                                        },
                                        child: Icon(Icons.close, size: 22.sp),
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      "لماذا تريد حذف اعلانك ؟",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    RadioListTile<int>(
                                      activeColor: Colors.green,
                                      contentPadding: EdgeInsets.zero,
                                      title: Text("تم البيع في لحج دوت كوم"),
                                      value: 0,
                                      groupValue: selectedReason,
                                      onChanged: (value) {
                                        setState(() => selectedReason = value!);
                                      },
                                    ),
                                    RadioListTile<int>(
                                      activeColor: Colors.green,
                                      contentPadding: EdgeInsets.zero,
                                      title: Text("تم البيع خارج لحج دوت كوم"),
                                      value: 1,
                                      groupValue: selectedReason,
                                      onChanged: (value) {
                                        setState(() => selectedReason = value!);
                                      },
                                    ),
                                    RadioListTile<int>(
                                      activeColor: Colors.green,
                                      contentPadding: EdgeInsets.zero,
                                      title: Text("لم اعد مهتما بالبيع"),
                                      value: 2,
                                      groupValue: selectedReason,
                                      onChanged: (value) {
                                        setState(() => selectedReason = value!);
                                      },
                                    ),
                                    SizedBox(height: 15.h),
                                    Container(
                                      padding: EdgeInsets.all(12.w),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withValues(
                                          alpha: 0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                          ),
                                          SizedBox(width: 10.w),
                                          Expanded(
                                            child: Text(
                                              "اذا حذفت هذا الإعلان، لن تتمكن من نشر إعلان جديد قبل 2 ساعات",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20.h),

                                    BlocProvider(
                                      create: (context) =>
                                          sl<DeleteMyAdvertisementCubit>(),
                                      child:
                                          BlocConsumer<
                                            DeleteMyAdvertisementCubit,
                                            BaseState<String>
                                          >(
                                            listener: (context, state) {
                                              if (!context.mounted) return;

                                              if (state.isSuccess) {
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      "تم حذف الإعلان بنجاح",
                                                    ),
                                                  ),
                                                );
                                              } else if (state.isFailure) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      "فشل الحذف: ${state.errorMessage}",
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            builder: (context, state) {
                                              return SizedBox(
                                                width: double.infinity,
                                                height: 45.h,
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),
                                                  onPressed: state.isLoading
                                                      ? null
                                                      : () {
                                                          if (!context.mounted)
                                                            return;

                                                          context
                                                              .read<
                                                                DeleteMyAdvertisementCubit
                                                              >()
                                                              .deleteMyAdvertisement(
                                                                id: item.id,
                                                                deletionReason:
                                                                    selectedReason ==
                                                                        0
                                                                    ? "تم البيع في لحج دوت كوم"
                                                                    : selectedReason ==
                                                                          1
                                                                    ? "تم البيع خارج لحج دوت كوم"
                                                                    : "لم اعد مهتما بالبيع",
                                                              );
                                                        },
                                                  child: state.isLoading
                                                      ? CircularProgressIndicator(
                                                          color: Colors.white,
                                                        )
                                                      : Text(
                                                          "حذف",
                                                          style: TextStyle(
                                                            fontSize: 15.sp,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                ),
                                              );
                                            },
                                          ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MainTitle extends StatelessWidget {
  final String text;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final int? maxLines;
  final TextOverflow? overflow;
  final IconData? icon;

  const MainTitle({
    super.key,
    required this.text,
    this.color = Colors.green,
    required this.fontSize,
    required this.fontWeight,
    this.textAlign,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.overflow,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.mainAppColor),
        SizedBox(width: 10.w),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            decoration: decoration,
            decorationColor: AppColors.mainAppColor,
            color: color,
          ),
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        ),
      ],
    );
  }
}
