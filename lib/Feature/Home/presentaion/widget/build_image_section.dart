import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constans/app_assets.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/constants.dart';
import '../../../../core/constans/fonts.dart';
import '../../Data/model/item_model.dart';

class BuildImageSection extends StatelessWidget {

  const BuildImageSection({
    super.key,
    required this.pageController,
    required this.imagecache,
    required this.name,
    required this.price,
    required this.currency,
    required this.regionName,
    required this.area,
    required this.item,
  });

  final PageController pageController;
  final List imagecache;
  final String name;
  final String price;
  final String currency;
  final String regionName;
  final String area;
  final Item item;
  String formatDate(dynamic rawDate) {
    late DateTime itemDate;

    // التأكد إذا التاريخ String أو DateTime
    if (rawDate is String) {
      try {
        itemDate = DateTime.parse(rawDate);
      } catch (e) {
        return 'تاريخ غير صالح';
      }
    } else if (rawDate is DateTime) {
      itemDate = rawDate;
    } else {
      return 'تاريخ غير معروف';
    }

    final now = DateTime.now();
    final difference = now.difference(itemDate);

    if (difference.inDays < 30) {
      // التاريخ أقل من شهر - نعرضه بصيغة مفهومة وبأرقام إنجليزية
      return DateFormat('yyyy-MM-dd', 'en_US').format(itemDate);
    } else {
      final months = (difference.inDays / 30).floor();
      final engNumber = NumberFormat("###", "en_US").format(months);

      if (months == 1) return 'منذ شهر';
      if (months == 2) return 'منذ شهرين';
      if (months >= 3 && months <= 10) return 'منذ $engNumber شهور';
      return 'منذ $engNumber أشهر';
    }
  }
  Widget build(BuildContext context) {
    final displayDate = formatDate(item.date);

    return Container(
      margin: EdgeInsets.all(12.sp),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200.h,
            child: PageView.builder(
              controller: pageController,
              physics: const BouncingScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  height: 200.h,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  imageUrl: "$imageadd$imagecache",
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                );
              },
            ),

          ),
          SizedBox(height: 5.h),
          Center(
            child: SmoothPageIndicator(
              controller: pageController,
              count: imagecache.length,
              axisDirection: Axis.horizontal,
              effect: SlideEffect(
                spacing: 8.0,
                radius: 25,
                dotWidth: 16,
                dotHeight: 16.0,
                paintStyle: PaintingStyle.stroke,
                strokeWidth: 1.5,
                dotColor: Colors.grey,
                activeDotColor: AppColors.mainAppColor,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: Fonts.font,
                  color: AppColors.mainAppColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
              Icon(
                Icons.forward_10_sharp,
                color: AppColors.mainAppColor,
              )
            ],
          ),
          SizedBox(height: 4.h),
          RichText(
            text: TextSpan(
              text: price,
              style: TextStyle(
                fontFamily: Fonts.font,
                color: AppColors.mainAppColor,
                fontWeight: FontWeight.w300,
                fontSize: 12.sp,
              ),
              children: [
                TextSpan(
                  text: currency,
                  style: TextStyle(
                    fontFamily: Fonts.font,
                    color: AppColors.mainAppColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              SvgPicture.asset(AppAssets.dataIcon),
              const SizedBox(width: 8),
              Text(
                "منذ $displayDate",
                style: TextStyle(
                  fontFamily: Fonts.font,
                  color: AppColors.hintTextColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(width: 20.w),
              SvgPicture.asset(AppAssets.locationIcon),
              SizedBox(width: 8.w),
              Text(
                "$regionName، $area,",
                style: TextStyle(
                  fontFamily: Fonts.font,
                  color: AppColors.hintTextColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
