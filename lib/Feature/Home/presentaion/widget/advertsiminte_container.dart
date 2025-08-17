import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/Home/Data/model/item_model.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/model/post_like_model.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/manger/get_all_favourite_cubit.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/manger/post_like_cubit.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';
import '../../../../core/constans/app_colors.dart';
import '../screen/item_details_screen.dart';
import 'package:intl/intl.dart';

class AdvertsiminteContainer extends StatefulWidget {
  const AdvertsiminteContainer({super.key, required this.item});

  final Item item;

  @override
  State<AdvertsiminteContainer> createState() =>
      _AdvertsiminteContainerState();
}

class _AdvertsiminteContainerState extends State<AdvertsiminteContainer> {
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
    final displayDate = formatDate(widget.item.date);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: GetIt.instance<GetAllFavouriteCubit>()..fetchFavouriteData(),
        ),
      ],
      child: BlocListener<PostLikeCubit, BaseState<PostLikeModel>>(
        listener: (context, state) {
          if (state.isSuccess) {
            final favouriteCubit = context.read<GetAllFavouriteCubit>();
            favouriteCubit.fetchFavouriteData();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(
                  widget.item.isLiked
                      ? "تم الحذف من المفضلة"
                      : "تمت الإضافة إلى المفضلة",
                  style: TextStyle(fontSize: 16.sp),
                ),
                backgroundColor:
                widget.item.isLiked ? Colors.red : Colors.green,
                duration: const Duration(seconds: 2),
              ),
            );

            // Confirm toggle after success
            setState(() {
              widget.item.isLiked = !widget.item.isLiked;
            });
          } else if (state.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "حدث خطأ، حاول مرة أخرى",
                  style: TextStyle(fontSize: 16.sp),
                ),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: GestureDetector(
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
                    color: Colors.black.withOpacity(0.2),
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
                    // Image container
                    Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.grey[200],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: (widget.item.advertisementImages != null &&
                            widget.item.advertisementImages.isNotEmpty)
                            ? CachedNetworkImage(
                          imageUrl:
                          widget.item.advertisementImages[0].imageName,
                          fit: BoxFit.cover,
                          width: 80.w,
                          height: 80.h,
                          progressIndicatorBuilder:
                              (context, url, progress) => Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                              strokeWidth: 2,
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey[600],
                              size: 30,
                            ),
                          ),
                        )
                            : Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[600],
                            size: 30,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title & Favorite
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
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<PostLikeCubit>()
                                      .postLike(widget.item.id);

                                  // Optional optimistic UI update
                                  setState(() {
                                    widget.item.isLiked = !widget.item.isLiked;
                                  });
                                },
                                child: Icon(
                                  widget.item.isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color: widget.item.isLiked
                                      ? Colors.green
                                      : Colors.grey,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          // Date & Service
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
                          // Area & Member
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: MainTitle(
                                  text: widget.item.area,
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
          ),
        ),
      ),
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
