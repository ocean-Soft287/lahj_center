import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lahijcenter/Feature/main/bottomNavbar/widget/drawer.dart';
import 'package:lahijcenter/core/constans/fonts.dart';
import 'package:lahijcenter/core/sharde/widget/navigation.dart';
import '../../../core/constans/app_assets.dart';
import '../../../core/constans/app_colors.dart';
import '../../../core/constans/responsve_font.dart';
import '../../AddAdvertisement/presentaion/screen/ad_guidelines_screen.dart';
import 'manager/Bottom_cubit.dart';
import 'manager/Bottom_state.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Bottomnav extends StatelessWidget {
  const Bottomnav({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocProvider(
      create: (context) => Bottomcubit(),
      child: BlocBuilder<Bottomcubit, Bottomstate>(
        builder: (context, state) {
          Bottomcubit homeCubit = BlocProvider.of(context);
          return Scaffold(
            appBar: homeCubit.currentIndex != 0
                ? AppBar(
              backgroundColor: AppColors.mainAppColor,
              title: Text(
                homeCubit.currentIndex == 1
                    ? "البريد الالكتروني"
                    : homeCubit.currentIndex == 2
                    ? "الاشعارات"
                    : "",
                style: TextStyle(
                  fontFamily: Fonts.font,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: getFontSize(context, 15),
                ),
              ),
              leading: const SizedBox(),
              centerTitle: true,
            )
                : null,
            key: scaffoldKey,
            backgroundColor: Colors.white,
            body: SafeArea(child: homeCubit.screen[homeCubit.currentIndex]),
            drawer: Customdrawer(cubit: homeCubit), // مرر الكيوبت هنا
            bottomNavigationBar: Directionality(
              textDirection: TextDirection.ltr,
              child: BottomAppBar(
                height: 55.h,
                shape: const CircularNotchedRectangle(),
                notchMargin: 0.0,
                color: AppColors.mainAppColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavItem(
                      currentIndex: homeCubit.currentIndex,
                      icon: AppAssets.homeIcon,
                      label: "الرئيسية",
                      index: 0,
                    ),
                    NavItem(
                      currentIndex: homeCubit.currentIndex,
                      icon: AppAssets.emailIcon,
                      label: "البريد الالكتروني",
                      index: 1,
                    ),
                    SizedBox(width: 40.w),
                    NavItem(
                      currentIndex: homeCubit.currentIndex,
                      icon: AppAssets.notificationIcon,
                      label: "الاشعارات",
                      index: 2,
                    ),
                    NavItem(
                      currentIndex: homeCubit.currentIndex,
                      icon: AppAssets.personIcon,
                      label: "المزيد",
                      index: 3,
                      isMenu: true,
                      scaffoldKey: scaffoldKey,
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.mainAppColor,
              elevation: 5,
              shape: const CircleBorder(),
              onPressed: () {
                navigato(context, const AdGuidelinesScreen());
              },
              child: Icon(Icons.add, size: 30.sp, color: Colors.white),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          );
        },
      ),
    );
  }
}

class CustomDrawerTile extends StatelessWidget {
  final String iconPath; // مسار الأي
  final String title;
  final VoidCallback onTap;

  const CustomDrawerTile({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        iconPath,
        width: 24,
        height: 24,
        color: AppColors.mainAppColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: Fonts.font,
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: getFontSize(context, 12),
        ),
      ),
      onTap: onTap,
    );
  }
}

class NavItem extends StatelessWidget {
  final int currentIndex;
  final String icon;
  final String label;
  final int index;
  final bool isMenu;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const NavItem({
    super.key,
    required this.currentIndex,
    required this.icon,
    required this.label,
    required this.index,
    this.isMenu = false,
    this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = currentIndex == index;
    return GestureDetector(
      onTap: () {
        if (isMenu && scaffoldKey != null) {
          scaffoldKey!.currentState?.openDrawer();
        } else {
          BlocProvider.of<Bottomcubit>(
            context,
          ).changeSelectIndexBottom(index: index);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            color: isActive ? Colors.white : Colors.grey[400],
            width: 24, // ضبط الحجم حسب الحاجة
            height: 19,
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: Fonts.font,
              color: isActive ? Colors.white : Colors.grey[400],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

void showPlatformDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "شارك ل",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.grey[200],
                ),
                child: Column(
                  children: [
                    Icon(Icons.android, size: 40.sp, color: Colors.black),
                    Text(
                      "مستخدم Android",
                      style: TextStyle(
                        fontFamily: Fonts.font,
                        fontSize: 16.sp,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text("أو", style: TextStyle(fontSize: 16.sp)),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.grey[200],
                ),
                child: Column(
                  children: [
                    Icon(Icons.apple, size: 40.sp, color: Colors.black),
                    Text(
                      "مستخدم iOS",
                      style: TextStyle(
                        fontFamily: Fonts.font,
                        fontSize: 16.sp,
                        color: AppColors.mainAppColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
