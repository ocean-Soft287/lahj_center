import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lahijcenter/Feature/intial/who_are.dart';
import 'package:lahijcenter/core/constans/app_colors.dart';
import '../../core/constans/fonts.dart';
import '../Auth/presentation/screen/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  late AnimationController _imageController;
  late Animation<double> _imageScaleAnimation;

  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();

    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _imageScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.8, end: 1.1)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.1, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_imageController);

    Future.delayed(const Duration(milliseconds: 500), () {
      _imageController.forward();
    });

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _bounceAnimation = Tween<double>(
      begin: -10.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeInOut,
    ));

    _bounceController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _imageController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "مرحبا!",
                        style: TextStyle(
                          fontFamily: Fonts.font,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "👋",
                        style: TextStyle(fontSize: 28.sp),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      border: Border.all(
                        color: AppColors.greyColor,
                        width: .5,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 6.w),
                        Text(
                          "أهلا وسهلا بك",
                          style: TextStyle(
                            fontFamily: Fonts.font,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.green[700],
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          "✨",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  AnimatedBuilder(
                    animation: _imageScaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _imageScaleAnimation.value,
                        child: Container(
                          padding: EdgeInsets.all(30.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.15),
                                spreadRadius: 5,
                                blurRadius: 20,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            "assets/image/WhatsApp Image 2025-12-23 at 10.57.46 AM.jpeg",
                            width: 220.w,
                            height: 150.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 20.h),

                  AnimatedBuilder(
                    animation: _bounceAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _bounceAnimation.value),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const WhoAre(),
                              ),
                            );
                          },
                          child: Container(
                            height: 50.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(25.r),
                              border: Border.all(
                                color: AppColors.mainAppColor.withValues(alpha:0.3),
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: AppColors.mainAppColor.withValues(alpha:0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.visibility,
                                    color: AppColors.mainAppColor,
                                    size: 18.sp,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  "من نحن؟",
                                  style: TextStyle(
                                    fontFamily: Fonts.font,
                                    color: AppColors.mainAppColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 40.h),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 50.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.mainAppColor,
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.mainAppColor.withValues(alpha:0.4),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 22.sp,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            "تسجيل الدخول",
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                 // SizedBox(height: 15.h),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}