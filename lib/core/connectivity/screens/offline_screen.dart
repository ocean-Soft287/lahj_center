import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lahijcenter/core/constans/app_colors.dart';
import 'package:lahijcenter/core/constans/fonts.dart';

class OfflineScreen extends StatefulWidget {
  const OfflineScreen({super.key});

  @override
  State<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        color: Colors.white.withValues(alpha:0.95),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated WiFi icon
                  TweenAnimationBuilder<double>(
                    duration: const Duration(seconds: 2),
                    tween: Tween<double>(begin: 0.5, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Icon(
                          Icons.wifi_off_rounded,
                          size: 120.sp,
                          color: AppColors.mainAppColor.withValues(alpha:0.7),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    'لا يوجد اتصال بالإنترنت',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color:  AppColors.mainAppColor,
                      fontFamily: Fonts.font
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'سيتم استكمال التطبيق تلقائياً عند عودة الاتصال',
                    style: TextStyle(
                      fontFamily: Fonts.font,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 48.h),
                  // Animated searching indicator
                  TweenAnimationBuilder<double>(
                    duration: const Duration(seconds: 1),
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Container(
                        width: double.infinity,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: AppColors.mainAppColor.withValues(alpha:0.1 * value),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.mainAppColor.withValues(alpha:0.3 * value),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20.sp,
                                height: 20.sp,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                     AppColors.mainAppColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'جاري البحث عن الاتصال...',
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color:  AppColors.mainAppColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}