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
      child:
      Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.h),
            margin: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.sp),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .3),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, 5),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person,color: AppColors.mainAppColor,),
                    SizedBox(width: 10.w,),
                    Text(
                      "معلومات المعلن",
                      style: TextStyle(
                        fontFamily: Fonts.font,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                BlocBuilder<Bottomcubit, Bottomstate>(
                  builder: (context, state) {
                    Bottomcubit bottomcubit = BlocProvider.of<Bottomcubit>(context);
                    return Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                            backgroundColor: AppColors.greyColor,
                            child: Icon(Icons.person,color: AppColors.mainAppColor,)),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.memberName,
                              style: TextStyle(
                                fontFamily: Fonts.font,
                                color: AppColors.mainAppColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 15.sp,
                              ),
                            ),

                            Text(
                              item.serviceName,
                              style: TextStyle(
                                fontFamily: Fonts.font,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w300,
                                fontSize: 15.sp,
                              ),
                            ),

                          ],
                        ),
                        const Spacer(),


                        buildIconButton(AppAssets.whatsAppIcon, () {
                          bottomcubit.whatsappuser(item.phone);
                        }),
                        SizedBox(width: 5.w),
                        buildIconButton(AppAssets.phoneIcon, () {
                          bottomcubit.callinguser(item.phone);
                        }),
                        SizedBox(width: 5.w),
                        buildIconButton("assets/icons/chat.svg", () {

                        }),


                      ],
                    );
                  },
                ),


              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10.h,
              bottom: 10.h,
              top: 10.h
            ),
            margin: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.sp),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .3),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, 5),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                      Icon(Icons.info_outline,color: AppColors.mainAppColor),
                    SizedBox(width: 10.w),
                    Text(
                      "المواصفات",
                      style: TextStyle(
                        fontFamily: Fonts.font,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                buildSpecificationRow(' الفئة:', item.groupName),

                SizedBox(height: 5.h),
                buildSpecificationRow(' الخدمة :', item.serviceName),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildIconButton(String asset, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6.sp),
        decoration: BoxDecoration(
          color: AppColors.mainAppColor,
          borderRadius: BorderRadius.circular(5.sp),
        ),

        child: SvgPicture.asset(asset, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        width: 20,
        height: 20,),
      ),
    );
  }

  Widget buildSpecificationRow(String label, String value) {
    return Container(
      padding: EdgeInsets.all(5.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.shade300
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: Fonts.font,
                color: Colors.grey,
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
                fontWeight: FontWeight.w400,
                fontSize: 15.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
