import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/constans/app_assets.dart';
import '../../../../core/constans/app_colors.dart';
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
    required this.govrnment,
    required this.area,
    required this.item,
  });

  final PageController pageController;
  final List<String> imagecache;
  final String name;
  final String price;
  final String currency;
  final String govrnment;

  final String area;
  final Item item;

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

  Widget build(BuildContext context) {
    final displayDate = formatDate(item.date);

    return Container(
      margin: EdgeInsets.all(12.sp),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imagecache.isEmpty
              ? SizedBox.shrink()
              : Stack(
                  children: [
                    SizedBox(
                      height: 200.h,
                      child: PageView.builder(
                        controller: pageController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: imagecache.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenImageViewer(
                                      imageUrl: imagecache[index],
                                      heroTag: 'image_$index',
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Hero(
                                  tag: 'image_$index',
                                  child: Stack(
                                    children: [
                                      /// الصورة
                                      CachedNetworkImage(
                                        height: 200.h,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        imageUrl: imagecache[index],
                                        placeholder: (context, url) {
                                          return Skeletonizer(
                                            enabled: true,
                                            child: Container(
                                              height: 200.h,
                                              width: double.infinity,
                                              color: Colors.grey[300],
                                            ),
                                          );
                                        },
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),

                                      Positioned.fill(
                                        child: Center(
                                          child: Image.asset(
                                            "assets/image/WhatsApp_Image_2025-12-10_at_5.01.35_PM-removebg-preview.png",
                                             width: 100,
                                            height: 100,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // الـ Indicator ثابت فوق الصور
                    Positioned(
                      bottom: 20.h,
                      left: 0,
                      right: 0,
                      child: Center(
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
                            dotColor: Colors.white.withOpacity(0.5),
                            activeDotColor: AppColors.mainAppColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          SizedBox(height: 8.h),

          Container(
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
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: Fonts.font,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.mainAppColor.withValues(alpha: .3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: price,
                        style: TextStyle(
                          fontFamily: Fonts.font,
                          color: AppColors.mainAppColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 15.sp,
                        ),
                        children: [
                          TextSpan(
                            text: currency,
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              color: AppColors.mainAppColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.dataIcon,
                                colorFilter: ColorFilter.mode(
                                  Colors.grey.shade500,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "$displayDate",
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 30.w),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.locationIcon,
                                colorFilter: ColorFilter.mode(
                                  Colors.grey.shade500,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                " $area",
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}

class FullScreenImageViewer extends StatelessWidget {
  final String imageUrl;
  final String heroTag;

  const FullScreenImageViewer({super.key, required this.imageUrl, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: Hero(
            tag: heroTag,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator(color: AppColors.mainAppColor)),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error, color: Colors.white, size: 50)),
            ),
          ),
        ),
      ),
    );
  }
}
