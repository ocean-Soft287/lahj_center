import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/category_bloc/category_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/currency_bloc/currency_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/government_bloc/government_bloc.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/blocs/services_bloc/services_bloc.dart';
import 'package:lahijcenter/core/sharde/widget/navigation.dart';
import '../../../../../../../core/constans/app_colors.dart';
import '../../../../../../../core/sharde/widget/default_button.dart';
import '../../../../core/utils/services/services_locator.dart';
import 'add_ad_screen.dart';
import '../../../../core/constans/fonts.dart';

class AdGuidelinesScreen extends StatefulWidget {
  const AdGuidelinesScreen({super.key});

  @override
  State<AdGuidelinesScreen> createState() => _AdGuidelinesScreenState();
}

class _AdGuidelinesScreenState extends State<AdGuidelinesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'شروط إضافة الإعلان',
          style: TextStyle(
            fontFamily: Fonts.font,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 60.h,
        backgroundColor: AppColors.mainAppColor,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.mainAppColor,
                    AppColors.mainAppColor.withOpacity(0.1),
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Container(
                  padding: EdgeInsets.all(16.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    'للمتابعة في إضافة الإعلان لابد من الموافقة على الشروط التالية:',
                    style: TextStyle(
                      fontFamily: Fonts.font,
                      color: AppColors.mainAppColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            // Main content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quranic verse section
                  Container(
                    padding: EdgeInsets.all(20.sp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: AppColors.mainAppColor.withOpacity(0.2),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mainAppColor.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mainAppColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            '( ﷽ )',
                            style: GoogleFonts.amiri(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainAppColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          '﴿ وَأَوْفُوا بِعَهْدِ اللَّهِ إِذَا عَاهَدتُّمْ وَلَا تَنقُضُوا الْأَيْمَانَ بَعْدَ تَوْكِيدِهَا وَقَدْ جَعَلْتُمُ اللَّهَ عَلَيْكُمْ كَفِيلًا ۚ إِنَّ اللَّهَ يَعْلَمُ مَا تَفْعَلُونَ﴾',
                          style: GoogleFonts.amiri(
                            fontSize: 18.sp,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            height: 1.8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Commitment section
                  Container(
                    padding: EdgeInsets.all(20.sp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.sp),
                              decoration: BoxDecoration(
                                color: AppColors.mainAppColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(
                                Icons.handshake_outlined,
                                color: AppColors.mainAppColor,
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                "اتعهد وأقسم بالله أنني المعلن:",
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  color: AppColors.mainAppColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),

                        // Guidelines list
                        _buildGuidelineItem(
                          icon: Icons.check_circle_outline,
                          text:
                          "تتعهد بعدم إضافة أي إعلان أو رد لا يتعلق بالبيع أو الشراء أو أي إعلان أو رد غير جاد",
                        ),
                        SizedBox(height: 15.h),
                        _buildGuidelineItem(
                          icon: Icons.check_circle_outline,
                          text: "تتعهد بعدم بخس أي سلعة",
                        ),
                        SizedBox(height: 15.h),
                        _buildGuidelineItem(
                          icon: Icons.check_circle_outline,
                          text: "تتعهد بعدم الإعلان عن أي سلعة ممنوعة بالموقع",
                        ),
                        SizedBox(height: 15.h),
                        _buildGuidelineItem(
                          icon: Icons.check_circle_outline,
                          text: "تتعهد بالالتزام بشروط استخدام الخدمة",
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Continue button
                  DefaultButton(
                    function: () {
                      navigato(
                        context,
                        MultiBlocProvider(
                          providers: [
                            BlocProvider(create: (context) => sl<GovernmentBloc>()),
                            BlocProvider(create: (context) => sl<ServicesBloc>()),
                            BlocProvider(create: (context) => sl<CurrencyBloc>()),
                            BlocProvider(create: (context) => sl<CategoryBloc>()),
                          ],
                          child: AddAdvertisementScreen(),
                        ),
                      );
                    },
                    text: "استمرار",
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelineItem({required IconData icon, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 2.h),
          padding: EdgeInsets.all(4.sp),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.green,
            size: 20.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: Fonts.font,
              color: Colors.black87,
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}