import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lahijcenter/Feature/Home/Data/model/item_model.dart';
import '../../../../core/constans/app_colors.dart';
import '../my_favorite_ad_sscreen.dart';

class FavouriteContainer extends StatelessWidget {
  const FavouriteContainer({super.key, required this.item, this.onTap});
final Item item;
final void Function()? onTap;

String formatDate(dynamic rawDate) {
    late DateTime itemDate;

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

    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: SizeUtility(context).height * 0.12,
                        child: AspectRatio(
                          aspectRatio: 2 / 1.4,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                progressIndicatorBuilder: (context, url, progress) =>
                                    Center(
                                      child: CircularProgressIndicator(
                                        value: progress.progress,
                                      ),
                                    ),
                                imageUrl: item.advertisementImages[0].imageName,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ),
                          ),
                        ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: MainTitle(
                                    text:
                                    item.name, // اسم الإعلان ثابت
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.mainAppColor,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                GestureDetector(
                                  onTap:onTap,
                                  child: const Icon(
                                    Icons.favorite,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: MainTitle(
                                    text:displayDate, // وقت ثابت
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.hintTextColor,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                MainTitle(
                                  text: item.serviceName, // اسم الخدمة ثابت
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
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: MainTitle(
                                    text: "${item.governorateName}، ${item.area},",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.hintTextColor,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(width: 30.w),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color:
                                        AppColors.thrideAppColor,
                                      ),
                                      SizedBox(width: 5.w),
                                      Flexible(
                                        child: MainTitle(
                                          text: item.memberName,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color:
                                          AppColors.hintTextColor,
                                          overflow:
                                          TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
