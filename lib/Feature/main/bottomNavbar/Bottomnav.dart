import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lahijcenter/core/constans/fonts.dart';
import 'package:lahijcenter/core/sharde/widget/navigation.dart';
import 'package:lahijcenter/core/sharde/widget/share_app.dart';
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
            resizeToAvoidBottomInset: true,
            appBar: (homeCubit.currentIndex == 1 || homeCubit.currentIndex == 2)
                ? AppBar(
              backgroundColor: AppColors.mainAppColor,
              title: Text(
                homeCubit.currentIndex == 1 ? "البريد الالكتروني" : "الاشعارات",
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
            bottomNavigationBar: Directionality(
              textDirection: TextDirection.rtl,
              child: BottomAppBar(
                height: 60.h,
                shape: const CircularNotchedRectangle(),
                notchMargin: 6.0,
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
                      label: "حسابي",
                      index: 3,
                     // isMenu: true,
                     // scaffoldKey: scaffoldKey,
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: FloatingActionButton(
                backgroundColor: AppColors.mainAppColor,
                elevation: 0,
                shape: const CircleBorder(),
                onPressed: () {
                  navigato(context, const AdGuidelinesScreen());
                },
                child: Icon(Icons.add, size: 30.sp, color: Colors.white),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          );
        },
      ),
    );
  }
}



class CustomDrawerTile extends StatelessWidget {
  final String iconPath;
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
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: Fonts.font,
          color: Colors.black,
          fontWeight: FontWeight.w700,
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
  final bool wight;


  const NavItem({
    super.key,
    required this.currentIndex,
    required this.icon,
    required this.label,
    required this.index,
    this.isMenu = false,
    this.scaffoldKey,
     this.wight=false,
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
            colorFilter:
            isActive?ColorFilter.mode(Colors.white, BlendMode.srcIn):ColorFilter.mode(Colors.black, BlendMode.srcIn),
            width: 24,
            height: 19,
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: Fonts.font,
              color: isActive ? Colors.white : Colors.black,
              fontSize: getFontSize(context, 10),
              fontWeight: wight?FontWeight.bold:FontWeight.w500,
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
        contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "شارك ل",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),

            GestureDetector(
              onTap: () {
                ShareAppHelper.shareAndroidAppLink();
              },
              child: Container(
                width: 120.w,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha:0.15),
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.android, size: 44.sp, color: Colors.black),
                    SizedBox(height: 8.h),
                    Text(
                      "مستخدم Android",
                      style: TextStyle(
                        fontFamily: Fonts.font,
                        fontSize: 14.sp,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "أو",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.h),

            // خيار iOS
            GestureDetector(
              onTap: () {
                ShareAppHelper.shareIOSAppLink();
                // يمكنك هنا إضافة منطق مشاركة خاص بـ iOS
              },
              child: Container(
                width: 120.w,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha:0.15),
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.apple, size: 44.sp, color: Colors.black),
                    SizedBox(height: 8.h),
                    Text(
                      "مستخدم iOS",
                      style: TextStyle(
                        fontFamily: Fonts.font,
                        fontSize: 14.sp,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
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