import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lahijcenter/Feature/Home/Data/model/item_model.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/model/get_all_favourite_model.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/model/post_like_model.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/model/unlike_home.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/manger/get_all_favourite_cubit.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/manger/post_like_cubit.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/manger/unlike_home_cubit.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';
import '../../../../core/constans/app_colors.dart';
import '../screen/item_details_screen.dart';

class AdvertsiminteContainer extends StatefulWidget {
  const AdvertsiminteContainer({super.key, required this.item});

  final Item item;

  @override
  State<AdvertsiminteContainer> createState() => _AdvertsiminteContainerState();
}

class _AdvertsiminteContainerState extends State<AdvertsiminteContainer> {
  String formatDate(dynamic rawDate) {
    late DateTime itemDate;

    if (rawDate is String) {
      try {
        itemDate = DateTime.parse(rawDate);
      } catch (e) {
        return 'تاريخ غير صالح'.tr();
      }
    } else if (rawDate is DateTime) {
      itemDate = rawDate;
    } else {
      return 'تاريخ غير معروف'.tr();
    }

    final now = DateTime.now();
    final difference = now.difference(itemDate);

    if (difference.inDays < 30) {
      return DateFormat('yyyy-MM-dd', 'en_US').format(itemDate);
    } else {
      final months = (difference.inDays / 30).floor();
      final engNumber = NumberFormat("###", "en_US").format(months);

      if (months == 1) return 'منذ شهر'.tr();
      if (months == 2) return 'منذ شهرين'.tr();
      if (months >= 3 && months <= 10) return 'منذ $engNumber شهور'.tr();
      return 'منذ $engNumber أشهر'.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayDate = formatDate(widget.item.date);

    return MultiBlocListener(
      listeners: [
        BlocListener<PostLikeCubit, BaseState<PostLikeModel>>(
          listener: (context, state) {
            if (state.isSuccess) {
              context.read<GetAllFavouriteCubit>().fetchFavouriteData();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 12.w),
                      Text("تمت الإضافة إلى المفضلة"),
                    ],
                  ),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.all(16),
                ),
              );

              setState(() {
                widget.item.isLiked = true;
              });
            } else if (state.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.white),
                      SizedBox(width: 12.w),
                      Text("حدث خطأ أثناء الإضافة"),
                    ],
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.all(16),
                ),
              );
            }
          },
        ),
        BlocListener<UnlikeHomeCubit, BaseState<UnlikeHome>>(
          listener: (context, state) {
            if (state.isSuccess) {
              context.read<GetAllFavouriteCubit>().fetchFavouriteData();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 12.w),
                      Text("تم الحذف من المفضلة"),
                    ],
                  ),
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.all(16),
                ),
              );

              setState(() {
                widget.item.isLiked = false;
              });
            } else if (state.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.white),
                      SizedBox(width: 12.w),
                      Text("حدث خطأ أثناء الحذف"),
                    ],
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.all(16),
                ),
              );
            }
          },
        ),
      ],
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ItemDetailsScreen(x: widget.item.id),
            ),
          );
        },
        child: BlocBuilder<GetAllFavouriteCubit, BaseState<GetAllFavourite>>(
          builder: (context, fav) {
            final isFavourite =
                fav.data?.items.any((item) => item.id == widget.item.id) ??
                false;
            return Card(
              margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: Container(
                            width: 70.w,
                            height: 70.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.grey[200]!, Colors.grey[300]!],
                              ),
                            ),
                            child: (widget.item.advertisementImages.isNotEmpty)
                                ? CachedNetworkImage(
                                    imageUrl: widget
                                        .item
                                        .advertisementImages[0]
                                        .imageName,
                                    fit: BoxFit.cover,
                                    width: 50.w,
                                    height: 50.h,
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
                                    errorWidget: (context, url, error) =>
                                        Center(
                                          child: Icon(
                                            Icons.image_not_supported_outlined,
                                            color: Colors.grey[400],
                                            size: 36.sp,
                                          ),
                                        ),
                                  )
                                : Center(
                                    child: Icon(
                                      Icons.image_not_supported_outlined,
                                      color: Colors.grey[400],
                                      size: 36.sp,
                                    ),
                                  ),
                          ),
                        ),
                        // New Badge (if needed)
                        Positioned(
                          top: 1,
                          right: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.mainAppColor,
                                  AppColors.mainAppColor.withValues(alpha: 0.8),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.mainAppColor.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              _getArabicStatus(widget.item.status),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16.w),
                    // Content Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: MainTitle(
                                  text: widget.item.name,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1F2937),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              Container(
                                width: 32.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  color: isFavourite
                                      ? AppColors.mainAppColor.withValues(
                                          alpha: 0.1,
                                        )
                                      : Colors.grey[100],
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isFavourite
                                        ? AppColors.mainAppColor.withValues(
                                            alpha: 0.3,
                                          )
                                        : Colors.grey[300]!,
                                    width: 1.5,
                                  ),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(15.r),
                                    onTap: () {
                                      if (isFavourite) {
                                        context
                                            .read<UnlikeHomeCubit>()
                                            .unlikeHome(widget.item.id);
                                      } else {
                                        context.read<PostLikeCubit>().postLike(
                                          widget.item.id,
                                        );
                                      }
                                    },
                                    child: Center(
                                      child: Icon(
                                        isFavourite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFavourite
                                            ? AppColors.mainAppColor
                                            : Colors.grey[600],
                                        size: 18.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),

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
                                      size: 14.sp,
                                      color: AppColors.mainAppColor,
                                    ),
                                    SizedBox(width: 6.w),
                                    Flexible(
                                      child: MainTitle(
                                        text: widget.item.serviceName,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.mainAppColor,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
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
                                    text: widget.item.governorateName,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF6B7280),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: 8.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time_rounded,
                                    size: 14.sp,
                                    color: Color(0xFF9CA3AF),
                                  ),
                                  SizedBox(width: 4.w),
                                  MainTitle(
                                    text: displayDate,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF9CA3AF),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
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
                                        color: AppColors.mainAppColor
                                            .withValues(alpha: 0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        size: 10.sp,
                                        color: AppColors.mainAppColor,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Flexible(
                                      child: MainTitle(
                                        text: widget.item.memberName,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF4B5563),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
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
            );
          },
        ),
      ),
    );
  }

  String _getArabicStatus(String status) {
    switch (status) {
      case 'New':
        return 'جديدة';
      case 'Delete':
        return 'محذوفة';
      case 'Approved':
        return 'مقبوله';
      default:
        return status; // لو حصلت حالة مش موجودة
    }
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
    this.color,
    required this.fontSize,
    required this.fontWeight,
    this.textAlign = TextAlign.start,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        color: color,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
