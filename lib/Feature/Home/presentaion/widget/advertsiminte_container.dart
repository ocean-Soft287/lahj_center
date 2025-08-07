import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lahijcenter/Feature/Home/Data/model/item_model.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/manger/favourite_cubit.dart';
import 'package:lahijcenter/core/network/local/flutter_secure_storage.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../MyFavoriteAds/screen/my_favorite_ad_sscreen.dart';
import '../screen/item_details_screen.dart';
import 'package:intl/intl.dart';

class AdvertsiminteContainer extends StatefulWidget {
  const AdvertsiminteContainer({super.key, required this.item});

  final Item item;

  @override
  State<AdvertsiminteContainer> createState() => _AdvertsiminteContainerState();
}

class _AdvertsiminteContainerState extends State<AdvertsiminteContainer> {
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
    final displayDate = formatDate(widget.item.date);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailsScreen(x: widget.item.id),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.2),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: widget.item.advertisementImages.isEmpty?SizedBox.shrink():CachedNetworkImage(
                        imageUrl: widget.item.advertisementImages[0].imageName,
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                        progressIndicatorBuilder: (context, url, progress) => Center(
                          child: CircularProgressIndicator(value: progress.progress),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
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
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.mainAppColor,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          BlocBuilder<FavouriteCubit, FavouriteState>(
                            builder: (context, state) {
                              final favouriteCubit = BlocProvider.of<FavouriteCubit>(context);
                              return GestureDetector(
                                onTap: () async {
                                  final idString = await SecureStorageService.read(
                                    SecureStorageService.customerid,
                                  );
                                  final int id = int.tryParse(idString ?? '') ?? 0;

                                  setState(() {
                                    widget.item.isLiked = !widget.item.isLiked;
                                  });

                                  favouriteCubit.addoedeletefavourite(
                                    widget.item.id,
                                    !widget.item.isLiked,
                                  );
                                },
                                child: Icon(
                                  widget.item.isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color: Colors.green,
                                  size: 30,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: MainTitle(
                              text: displayDate,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.hintTextColor,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          MainTitle(
                            text: widget.item.serviceName,
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
                          Flexible(
                            child: MainTitle(
                              text: "${widget.item.area},",
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: AppColors.thrideAppColor,
                                ),
                                SizedBox(width: 5.w),
                                Flexible(
                                  child: MainTitle(
                                    text: widget.item.memberName,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.hintTextColor,
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
      )

    );
  }
}
