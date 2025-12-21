import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/Auth/presentation/screen/login_screen.dart';
import '../../../../core/constans/app_assets.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/fonts.dart';
import '../../../../core/constans/responsve_font.dart';
import '../../../../core/network/local/flutter_secure_storage.dart';
import '../../../../core/sharde/widget/navigation.dart';
import '../../../../core/utils/services/services_locator.dart';
import '../../../AddAdvertisement/presentaion/screen/ad_guidelines_screen.dart';
import '../../../MyFavoriteAds/screen/my_favorite_ad_sscreen.dart';
import '../../../licences/screen/privacy_policy.dart';
import '../../../licences/screen/terms_of_use.dart';
import '../../../my_ads/presentaion/screen/my_ads.dart';
import '../../../profile/manager/get_profile_cubit.dart';
import '../../../profile/manager/get_profile_state.dart';
import '../../../profile/screen/edit_profile.dart';
import '../manager/Bottom_cubit.dart';

class Customdrawer extends StatefulWidget {
  const Customdrawer({super.key});

  @override
  State<Customdrawer> createState() => _CustomdrawerState();
}

class _CustomdrawerState extends State<Customdrawer>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
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
    final cubit = context.read<Bottomcubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10.h, bottom: 20.h, left: 16.w, right: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: BlocProvider(
              create: (context) => GetIt.instance<GetProfileCubit>()..fetchProfile(),
              child: BlocBuilder<GetProfileCubit, GetProfileState>(
                builder: (context, state) {
                  if (state is GetProfileLoading) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: CircularProgressIndicator(
                          color: AppColors.mainAppColor,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  } else if (state is GetProfileSuccess) {
                    final profile = state.profile;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.keyboard_backspace_outlined),
                            SizedBox(width: 30.w),
                            Text(
                              'حسابي',
                              style: TextStyle(
                                fontFamily: Fonts.font,
                                fontSize: getFontSize(context, 16),
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Container(
                              width: 80.w,
                              height: 80.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.mainAppColor.withValues(alpha:0.3),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha:0.1),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: profile.imageUrl != null && profile.imageUrl!.isNotEmpty
                                    ? FadeInImage.assetNetwork(
                                  placeholder: 'assets/image/background.png',
                                  image: profile.imageUrl!,
                                  fit: BoxFit.cover,
                                  imageErrorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        color: AppColors.mainAppColor.withValues(alpha:0.1),
                                        child: Icon(
                                          Icons.person,
                                          color: AppColors.mainAppColor,
                                          size: 40.sp,
                                        ),
                                      ),
                                )
                                    : Container(
                                  color: AppColors.mainAppColor.withValues(alpha:0.1),
                                  child: Icon(
                                    Icons.person,
                                    size: 40.sp,
                                    color: AppColors.mainAppColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  profile.firstName,
                                  style: TextStyle(
                                    fontFamily: Fonts.font,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: getFontSize(context, 18),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  profile.phoneNumber.toString(),
                                  style: TextStyle(
                                    fontFamily: Fonts.font,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w400,
                                    fontSize: getFontSize(context, 12),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () async {
                                Navigator.pop(context);
                                final result = await Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) => const ProfileScreen(),
                                  ),
                                );
                                if (result == true) {
                                  context.read<GetProfileCubit>().fetchProfile();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: AppColors.mainAppColor.withValues(alpha: .3),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Icon(
                                  Icons.edit_outlined,
                                  size: 20.sp,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Text(
                          "فشل تحميل الملف",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: getFontSize(context, 12),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),

          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(height: 8.h),

                    CustomDrawerTile(
                      iconPath: AppAssets.addAdIcon,
                      title: "أضف إعلانك معنا",
                      onTap: () {
                        navigato(context, const AdGuidelinesScreen());
                      },
                    ),

                    CustomDrawerTile(
                      iconPath: AppAssets.myAdsIcon,
                      title: "إعلاناتي",
                      onTap: () {
                        navigato(context, const MyAdsScreen());
                      },
                    ),

                    CustomDrawerTile(
                      iconPath: AppAssets.favoriteAdsIcon,
                      title: "إعلاناتي المفضلة",
                      onTap: () {
                        navigato(context, const MyFavoriteAdsScreen());
                      },
                    ),

                    CustomDrawerTile(
                      iconPath: AppAssets.emailIcon,
                      title: "البريد",
                      onTap: () {
                        cubit.changeSelectIndexBottom(index: 1);
                      },
                    ),

                    CustomDrawerTile(
                      iconPath: AppAssets.notificationsIcon,
                      title: "الإشعارات",
                      onTap: () {
                        cubit.changeSelectIndexBottom(index: 2);
                      },
                    ),

                    CustomDrawerTile(
                      iconPath: AppAssets.termsIcon,
                      title: "شروط الاستخدام",
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => const TermsOfUse()),
                        );
                      },
                    ),

                    CustomDrawerTile(
                      iconPath: AppAssets.privacyPolicyIcon,
                      title: "سياسة الخصوصية",
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => const PrivacyPolicyScreen()),
                        );
                      },
                    ),

                    CustomDrawerTile(
                      iconPath: AppAssets.shareIcon,
                      title: "شارك مع الأصدقاء",
                      onTap: () {
                        showPlatformDialog(context);
                      },
                    ),

                    CustomDrawerTile(
                      iconPath: AppAssets.logoutIcon,
                      title: "تسجيل الخروج",
                      onTap: () async {

                        await SecureStorageService.delete(SecureStorageService.email);
                        await SecureStorageService.delete(SecureStorageService.mobile);
                        await SecureStorageService.delete(SecureStorageService.name);
                        await SecureStorageService.delete(SecureStorageService.customerid);
                        await SecureStorageService.delete(SecureStorageService.token);


                        sl<Dio>().options.headers.remove('Authorization');


                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                              (route) => false,
                        );
                      },
                    ),


                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
        ],
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
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  width: 30.w,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(AppColors.mainAppColor, BlendMode.srcIn),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: Fonts.font,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Platform Dialog Function
void showPlatformDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text('شارك التطبيق', style: TextStyle(fontFamily: Fonts.font)),
      content: Text('اختر المنصة التي تريد المشاركة عليها', style: TextStyle(fontFamily: Fonts.font)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('إغلاق', style: TextStyle(fontFamily: Fonts.font)),
        ),
      ],
    ),
  );
}
