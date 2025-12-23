import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:lahijcenter/core/constans/app_colors.dart';
import '../../core/constans/fonts.dart';

class WhoAre extends StatefulWidget {
  const WhoAre({super.key});

  @override
  WhoAreState createState() => WhoAreState();
}

class WhoAreState extends State<WhoAre> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mainAppColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        title: Text(
          "من نحن",
          style: TextStyle(
            fontFamily: Fonts.font,
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[50]!,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _slideAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(maxWidth: 500.w),
                        padding: EdgeInsets.all(28.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white,
                              Colors.grey[50]!,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.mainAppColor.withOpacity(0.08),
                              offset: Offset(0, 8.h),
                              blurRadius: 24.r,
                              spreadRadius: 0,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              offset: Offset(0, 2.h),
                              blurRadius: 8.r,
                              spreadRadius: 0,
                            ),
                          ],
                          border: Border.all(
                            color: AppColors.mainAppColor.withOpacity(0.1),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: AppColors.mainAppColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.info_outline_rounded,
                                size: 48.sp,
                                color: AppColors.mainAppColor,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Text(
                              "لحج دوت كوم هي منصة إعلانية للتسويق الإلكتروني "
                                  "متخصصة في البيع والشراء. تم تأسيسها في مطلع "
                                  "شهر ديسمبر 2025 كأول منصة تسويقية إلكترونية في لحج. "
                                  "هو اختيارك الأول، والذي يمكن المستخدمين من التسويق لكل السلع في البيع "
                                  "والشراء والخدمات لتلك المنتجات الجديدة "
                                  "والمستعملة بكل سهولة، كما يسهم بمساعدة "
                                  "الأسر المنتجة بشكل خاص.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: Fonts.font,
                                fontSize: 16.sp,
                                color: Colors.grey[800],
                                height: 1.8,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.2,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Container(
                              height: 4.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.mainAppColor.withOpacity(0.3),
                                    AppColors.mainAppColor,
                                    AppColors.mainAppColor.withOpacity(0.3),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}