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
import '../../../AddAdvertisement/presentaion/screen/ad_guidelines_screen.dart';
import '../../../MyFavoriteAds/screen/my_favorite_ad_sscreen.dart';
import '../../../licences/screen/privacy_policy.dart';
import '../../../licences/screen/terms_of_use.dart';
import '../../../my_ads/presentaion/screen/my_ads.dart';
import '../../../profile/manager/get_profile_cubit.dart';
import '../../../profile/manager/get_profile_state.dart';
import '../../../profile/screen/edit_profile.dart';
import '../Bottomnav.dart';
import '../manager/Bottom_cubit.dart';
class Customdrawer extends StatelessWidget {
  final Bottomcubit cubit; // استقبال الكيوبت

  const Customdrawer({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          Container(
            height: 180.h,
            child: DrawerHeader(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(color: AppColors.mainAppColor),
              child: BlocProvider(
                create: (context) => GetIt.instance<GetProfileCubit>()..fetchProfile(),
                child: BlocBuilder<GetProfileCubit, GetProfileState>(
                  builder: (context, state) {
                    if (state is GetProfileLoading) {
                      return const Center(child: CircularProgressIndicator(color: Colors.white));
                    } else if (state is GetProfileSuccess) {
                      final profile = state.profile;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 70.w,
                            height: 70.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            child: ClipOval(
                              child: profile.imageUrl != null && profile.imageUrl!.isNotEmpty
                                  ? FadeInImage.assetNetwork(
                                placeholder: 'assets/image/background.png',
                                image: profile.imageUrl!,
                                fit: BoxFit.cover,
                                imageErrorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.person, color: Colors.white, size: 40),
                              )
                                  : Icon(Icons.person, size: 40.sp, color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            profile.firstName,
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: getFontSize(context, 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                          Text(
                            profile.email,
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                              fontSize: getFontSize(context, 11),
                              fontStyle: FontStyle.italic,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text(
                          "فشل تحميل الملف",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),


          CustomDrawerTile(
            iconPath: AppAssets.profileIcon,
            title: "تعديل الملف الشخصي",
            onTap: () async {
              Navigator.pop(context);
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
              if (result == true) {
                context.read<GetProfileCubit>().fetchProfile();
              }
            },
          ),
          CustomDrawerTile(
            iconPath: AppAssets.addAdIcon,
            title: "اضف اعلانك معنا",
            onTap: () {
              Navigator.pop(context);
              navigato(context, const AdGuidelinesScreen());
            },
          ),
          CustomDrawerTile(
            iconPath: AppAssets.myAdsIcon,
            title: "اعلانتي",
            onTap: () {
              Navigator.pop(context);
              navigato(context, const MyAdsScreen());
            },
          ),
          CustomDrawerTile(
            iconPath: AppAssets.favoriteAdsIcon,
            title: "اعلانتي المفضلة",
            onTap: () {
              Navigator.pop(context);
              navigato(context, const MyFavoriteAdsScreen());
            },
          ),
          CustomDrawerTile(
            iconPath: AppAssets.emailIcon,
            title: "البريد",
            onTap: () {
              cubit.changeSelectIndexBottom(index: 1);
              Navigator.pop(context);
            },
          ),
          CustomDrawerTile(
            iconPath: AppAssets.notificationsIcon,
            title: "الاشعارات",
            onTap: () {
              cubit.changeSelectIndexBottom(index: 2);
              Navigator.pop(context);
            },
          ),

          // Divider for separation
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Divider(color: Colors.grey.withOpacity(0.3), height: 1.h),
          ),

          CustomDrawerTile(
            iconPath: AppAssets.termsIcon,
            title: "شروط الاستخدام",
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TermsOfUse()),
              );
            },
          ),
          CustomDrawerTile(
            iconPath: AppAssets.privacyPolicyIcon,
            title: "سياسة الخصوصية",
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()),
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
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
              );
              ///دخة هخليه يسجل تاني مش هيحزف الحساب كامل
              await SecureStorageService.delete(SecureStorageService.email);
              await SecureStorageService.delete(SecureStorageService.mobile);
              await SecureStorageService.delete(SecureStorageService.name);
              await SecureStorageService.delete(SecureStorageService.customerid);
              await SecureStorageService.delete(SecureStorageService.token);
            },
          ),


          SizedBox(height: 30.h),


          Padding(
            padding: EdgeInsets.only(left: 24.w, bottom: 12.h,
            right: 12.h),
            child: Text(
              'تواصل معنا',
              style: TextStyle(
                fontFamily: Fonts.font,
                fontSize: getFontSize(context, 14),
                fontWeight: FontWeight.w600,
                color: AppColors.mainAppColor,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => cubit.whatsapp(),
                  child: SvgPicture.asset(
                    AppAssets.whatsAppIcon,
                    width: 36.w,
                    height: 36.h,
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 40.w),
                GestureDetector(
                  onTap: () => cubit.calling(),
                  child: SvgPicture.asset(
                    AppAssets.phoneIcon,
                    width: 36.w,
                    height: 36.h,
                    color: AppColors.mainAppColor,
                  ),
                ),
              ],
            ),
          ),

          // Bottom spacer
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}