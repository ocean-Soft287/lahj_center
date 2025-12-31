import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/model/get_all_favourite_model.dart';
import '../../../../core/constans/app_colors.dart';

class FavouriteContainer extends StatelessWidget {
  const FavouriteContainer({super.key, required this.item, this.onTap});

  final FavouriteItem item;
  final void Function()? onTap;

  String formatDate(dynamic rawDate) {
    late DateTime itemDate;

    if (rawDate is String) {
      try {
        itemDate = DateTime.parse(rawDate);
      } catch (_) {
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

  @override
  Widget build(BuildContext context) {
    final displayDate = formatDate(item.date);

    String? imageUrl;
    if (item.advertisementImages.isNotEmpty) {
      final first = item.advertisementImages.first;
      if (first is String) {
        imageUrl = first;
      } else if (first is Map) {
        final m = Map<String, dynamic>.from(first);
        imageUrl = (m['imageName'] ?? m['url'] ?? m['image'])?.toString();
      }
    }

    return Column(
      children: [
        Card(
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(14.sp),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey[200]!, Colors.grey[300]!],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: (imageUrl == null || imageUrl.isEmpty)
                            ? Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.grey[500],
                                  size: 36.sp,
                                ),
                              )
                            : CachedNetworkImage(
                                progressIndicatorBuilder:
                                    (context, url, progress) => Center(
                                      child: CircularProgressIndicator(
                                        value: progress.progress,
                                        strokeWidth: 2.5,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              AppColors.mainAppColor,
                                            ),
                                      ),
                                    ),
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
                                width: 100.w,
                                height: 100.h,
                                errorWidget: (context, url, error) => Center(
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                    color: Colors.grey[500],
                                    size: 36.sp,
                                  ),
                                ),
                              ),
                      ),
                    ),

                    // Favourite Badge
                  ],
                ),

                SizedBox(width: 16.w),

                // Content Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Remove Button Row
                      Row(
                        children: [
                          Expanded(
                            child: MainTitle(
                              text: item.name,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1F2937),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          // Remove from Favourite Button
                          Container(
                            width: 38.w,
                            height: 38.h,
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.green.withValues(alpha: 0.3),
                                width: 1.5,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(19.r),
                                onTap: onTap,
                                child: Center(
                                  child: Icon(
                                    Icons.favorite,
                                    color: AppColors.mainAppColor,
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h),

                      // Service Category Badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.mainAppColor.withValues(
                                alpha: 0.08,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.category_outlined,
                                  size: 13.sp,
                                  color: AppColors.mainAppColor,
                                ),
                                SizedBox(width: 6.w),
                                Flexible(
                                  child: MainTitle(
                                    text: item.serviceName,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.mainAppColor,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4.sp),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Icon(
                                  Icons.location_on,
                                  size: 14.sp,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                              SizedBox(width: 6.w),
                              MainTitle(
                                text: item.governorateEName,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF6B7280),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 8.h),

                      // Bottom Row: Date and Member
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Date with icon
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 13.sp,
                                color: Color(0xFF9CA3AF),
                              ),
                              SizedBox(width: 4.w),
                              MainTitle(
                                text: displayDate,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF9CA3AF),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                          // Member Badge
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 18.w,
                                  height: 18.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainAppColor.withValues(
                                      alpha: 0.2,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    size: 11.sp,
                                    color: AppColors.mainAppColor,
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Flexible(
                                  child: MainTitle(
                                    text: item.memberName,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF4B5563),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
  });

  @override
  Widget build(BuildContext context) {
    return Text(
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
    );
  }
}
