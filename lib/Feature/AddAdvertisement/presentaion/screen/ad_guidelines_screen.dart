import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lahijcenter/Feature/AddAdvertisement/manger/addadvertisminte_cubit.dart';
import 'package:lahijcenter/core/sharde/widget/navigation.dart';
import '../../../../../../../core/constans/app_colors.dart';
import '../../../../../../../core/sharde/widget/default_button.dart';
import 'add_ad_screen.dart';
import '../../../../core/constans/fonts.dart';


class AdGuidelinesScreen extends StatelessWidget {
  const AdGuidelinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<AddadvertisminteCubit>()..fetchgovermnet()..fetchcurrency()..fetchCategories(),
      child: BlocBuilder<AddadvertisminteCubit, AddadvertisminteState>(
  builder: (context, state) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          toolbarHeight: 40,
          backgroundColor: AppColors.mainAppColor,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'للمتابعة في إضافة الإعلان لابد من الموافقة على الشروط التالية:',
                style: TextStyle(
                  fontFamily: Fonts.font,
                  color: AppColors.mainAppColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  '( ﷽ )', // رمز البسملة بين قوسين
                  style: GoogleFonts.amiri(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  '﴿ وَأَوْفُوا بِعَهْدِ اللَّهِ إِذَا عَاهَدتُّمْ وَلَا تَنقُضُوا الْأَيْمَانَ بَعْدَ تَوْكِيدِهَا وَقَدْ جَعَلْتُمُ اللَّهَ عَلَيْكُمْ كَفِيلًا ۚ إِنَّ اللَّهَ يَعْلَمُ مَا تَفْعَلُونَ﴾',
                  style: GoogleFonts.amiri(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "اتعهد وأقسم بالله أنني المعلن:",
                style: TextStyle(
                  fontFamily: Fonts.font,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                " -تتعهد بعدم إضافة أي إعلان أو رد لا يتعلق بالبيع أو الشراء أو أي إعلان أو رد غير جاد",
                style: TextStyle(
                  fontFamily: Fonts.font,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 8.h), // مسافة بين النصوص
              Text(
                " -تتعهد بعدم بخس أي سلعة",
                style: TextStyle(
                  fontFamily: Fonts.font,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                " -تتعهد بعدم الإعلان عن أي سلعة ممنوعة بالموقع",
                style: TextStyle(
                  fontFamily: Fonts.font,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                " -تتعهد بالالتزام بشروط استخدام الخدمة",
                style: TextStyle(
                  fontFamily: Fonts.font,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 15.sp,
                ),
              ),
              const Spacer(),
              DefaultButton(
                function: () {
                  navigato(context, const AddAdvertisementScreen());
                },
                text: "استمرار",
              ),
            ],
          ),
        ),
      );
  },
),
    );
  }
}
