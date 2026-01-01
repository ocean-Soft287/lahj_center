import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../main/bottomNavbar/manager/slider_cubit.dart';

class BannerPage extends StatefulWidget {
  const BannerPage({super.key});

  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SliderCubit>();
    cubit.getSlider();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SliderCubit, SliderState>(
      listener: (context, state) {
        if (state is SliderSuccess) {}
        if (state is SliderError) {}
      },
      builder: (context, state) {
        if (state is SliderLoading) {
          return SizedBox(
            height: 150.h,
            child: Center(
              child: CircularProgressIndicator(color: Colors.green),
            ),
          );
        }

        if (state is SliderSuccess) {
          final banners = state.bannerSliderModel;

          if (banners.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            children: [
              CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: banners.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(5.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: banners[index].imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,

                        /// loading (بديل loadingBuilder)
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(color: Colors.green),
                        ),

                        /// error (بديل errorBuilder)
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 140.h,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: false,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              SizedBox(height: 8.h),
              AnimatedSmoothIndicator(
                activeIndex: _currentIndex,
                count: banners.length,
                effect: WormEffect(
                  dotHeight: 6.h,
                  dotWidth: 6.w,
                  activeDotColor: Colors.green,
                  dotColor: Colors.grey.shade300,
                  spacing: 4.w,
                ),
              ),
            ],
          );
        }

        if (state is SliderError) {
          return SizedBox(
            height: 150.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 40, color: Colors.red[300]),
                  SizedBox(height: 4.h),
                  Text(
                    state.failure.message,
                    style: TextStyle(color: Colors.red[700], fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
