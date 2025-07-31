import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constans/fonts.dart';


class WhoAre extends StatefulWidget {
  const WhoAre({super.key});

  @override
  WhoAreState createState() => WhoAreState();
}

class WhoAreState extends State<WhoAre> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60.h,
              color: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "من نحن",
                    style: TextStyle(
                      fontFamily: Fonts.font,
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Center(
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: Container(
                        width: 0.85.sw,
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(4.w, 4.h),
                              blurRadius: 8.r,
                              spreadRadius: 2.r,
                            ),
                          ],
                        ),
                        child: Text(
                          "لحج سنتر هي منصة إعلانية للتسويق الإلكتروني "
                              "متخصصة في البيع والشراء. تم تأسيسها في مطلع "
                              "شهر ديسمبر 2023 كأول منصة تسويقية إلكترونية في لحج. "
                              "هو اختيارك الأول، والذي يمكن المستخدمين من التسويق لكل السلع في البيع "
                              "والشراء والخدمات لتلك المنتجات الجديدة "
                              "والمستعملة بكل سهولة، كما يسهم بمساعدة "
                              "الأسر المنتجة بشكل خاص.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: Fonts.font,
                            fontSize: 16.sp,
                            color: Colors.black87,
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
