import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lahijcenter/Feature/Home/Data/model/item_model.dart';
import 'package:lahijcenter/Feature/main/bottomNavbar/manager/Bottom_cubit.dart';
import 'package:lahijcenter/core/constans/fonts.dart';

import '../../../../core/constans/app_assets.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../main/bottomNavbar/manager/Bottom_state.dart';

class BuildAdvertiserSection extends StatelessWidget {
  const BuildAdvertiserSection({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Bottomcubit(),
      child: Container(
        margin: EdgeInsets.all(12.sp),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "المعلن",
              style: TextStyle(
                fontFamily: Fonts.font,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 20.h),
            BlocBuilder<Bottomcubit, Bottomstate>(
              builder: (context, state) {
                Bottomcubit bottomcubit = BlocProvider.of<Bottomcubit>(context);
                return Row(
                  children: [
                    SvgPicture.asset(AppAssets.infoUserIcon),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.memberName,
                          style: TextStyle(
                            fontFamily: Fonts.font,
                            color: AppColors.mainAppColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 12.sp,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: 12.sp,
                        ),
                      ],
                    ),
                    const Spacer(),
                    buildIconButton(AppAssets.whatsAppIcon, () {
                      bottomcubit.whatsappuser("item.phone");
                    }),
                    SizedBox(width: 5.w),
                    buildIconButton(AppAssets.phoneIcon, () {
                      bottomcubit.callinguser("item0");
                    }),
                    SizedBox(width: 5.w),
                    buildIconButton(AppAssets.addAdIcon, () {
                      bottomcubit.sendhi("item.phone");

                    }),
                  ],
                );
              },
            ),
            SizedBox(height: 20.h),
            Text(
              "المواصفات",
              style: TextStyle(
                fontFamily: Fonts.font,
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 12.h),
            buildSpecificationRow('القسم الرئيسي:', item.serviceName),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  Widget buildIconButton(String asset, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6.sp),
        color: AppColors.mainAppColor,
        child: SvgPicture.asset(
          asset,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildSpecificationRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: Fonts.font,
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 12.sp,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            value,
            style: TextStyle(
              fontFamily: Fonts.font,
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }
}
