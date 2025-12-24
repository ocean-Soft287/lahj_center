import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/services/services_locator.dart';
import '../../../main/bottomNavbar/manager/slider_cubit.dart';

class BannerPage extends StatefulWidget {
  const BannerPage({super.key});

  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SliderCubit>();
   // print('🔥 Initial State: ${cubit.state}');
    cubit.getSlider();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SliderCubit, SliderState>(
      listener: (context, state) {
       // print('🔥 State Changed: $state');
        if (state is SliderSuccess) {
          //print('✅ Success! Banners count: ${state.bannerSliderModel.length}');
        }
        if (state is SliderError) {
        // print('❌ Error: ${state.failure.message}');
        }
      },
      builder: (context, state) {
       // print('🎨 Building with state: $state');

        if (state is SliderLoading) {
          return SizedBox(
            height: 180.h,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ),
          );
        }

        if (state is SliderSuccess) {
        //  print('🎯 Rendering Success State');
          final banners = state.bannerSliderModel;
          //print('📦 Banners: $banners');
         // print('📊 Banners Length: ${banners.length}');

          if (banners.isEmpty) {
            return const SizedBox.shrink();
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: CarouselSlider.builder(
              itemCount: banners.length,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      banners[index].imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                            color: Colors.green,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                      //  print('🖼️ Image Error: $error');
                      //  print('🔗 Image URL: ${banners[index].imagePath}');
                        return Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.grey[400],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 160.h,
                viewportFraction: 0.9,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          );
        }

        if (state is SliderError) {
          return SizedBox(
            height: 180.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red[300],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    state.failure.message,
                    style: TextStyle(
                      color: Colors.red[700],
                      fontSize: 14.sp,
                    ),
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