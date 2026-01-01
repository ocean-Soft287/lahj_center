import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/sub_area_bloc/sub_area_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/sub_catagory_bloc/sub_catagory_cubit.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/sharde/widget/default_button.dart';
import '../../../../core/utils/services/services_locator.dart';
import '../../../AddAdvertisement/blocs/category_bloc/category_bloc.dart';
import '../../../AddAdvertisement/blocs/currency_bloc/currency_bloc.dart';
import '../../../AddAdvertisement/blocs/government_bloc/government_bloc.dart';
import '../../../AddAdvertisement/blocs/services_bloc/services_bloc.dart';
import '../../../Home/Data/model/item_model.dart';
import '../../../Home/update_advertisement/presentation/screens/edite_advertisement_screen.dart';

class Myadscontainer extends StatefulWidget {
  const Myadscontainer({super.key, required this.item, required this.function});

  final Item item;
  final Function function;

  @override
  State<Myadscontainer> createState() => _MyadscontainerState();
}

class _MyadscontainerState extends State<Myadscontainer> {
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
                  child: widget.item.advertisementImages.isEmpty
                      ? Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[600],
                            size: 40.sp,
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl:
                              widget.item.advertisementImages[0].imageName,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,

                          placeholder: (context, url) => Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),

                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.grey[600],
                              size: 40.sp,
                            ),
                          ),
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
                          text: widget.item.name,
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
                        text: widget.item.serviceName,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.hintTextColor,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      MainTitle(
                        icon: Icons.location_on,
                        text: widget.item.governorateEName,
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
                        text: widget.item.price.toString(),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.hintTextColor,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      MainTitle(
                        icon: Icons.info,
                        text: widget.item.condition,
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
                        child: EdittAdvertisementScreen(item: widget.item),
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
              child: DefaultButton(
                text: "حذف",
                function: () => widget.function(),
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
