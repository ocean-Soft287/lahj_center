import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.mainAppColor),
            child: FutureBuilder(
              future: Future.wait([
                SecureStorageService.read(SecureStorageService.name),
                SecureStorageService.read(SecureStorageService.email),
                SecureStorageService.read(SecureStorageService.image),
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('حدث خطأ أثناء تحميل البيانات'),
                  );
                }

                final name = snapshot.data?[0] ?? '';
                final email = snapshot.data?[1] ?? '';
                final imagePath = snapshot.data?[2] ?? '';

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: AppColors.greyColor,
                        shape: BoxShape.circle,
                      ),
                      child: imagePath.isNotEmpty
                          ? ClipOval(
                        child: Image.network(
                          "http://78.89.159.126:9393/TheOneLahjAPI/CustomerImages/$imagePath",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                        ),
                      )
                          : Icon(Icons.person, size: 40.sp, color: Colors.white),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: Fonts.font,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: getFontSize(context, 12),
                      ),
                    ),
                    Text(
                      email,
                      style: TextStyle(
                        fontFamily: Fonts.font,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: getFontSize(context, 12),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          CustomDrawerTile(
            iconPath: AppAssets.profileIcon,
            title: "تعديل الملف الشخصي",
            onTap: () {
              Navigator.pop(context);
              navigato(context, const EditProfileScreen());
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
            title: "اعلانتي ",
            onTap: () {
              Navigator.pop(context);
              navigato(context, const MyAdsScreen());
            },
          ),
          CustomDrawerTile(
            iconPath: AppAssets.favoriteAdsIcon,
            title: "اعلانتي المفضلة",
            onTap: () {
              navigato(context, const MyFavoriteAdsScreen());
            },
          ),
          CustomDrawerTile(
            iconPath: AppAssets.emailIcon,
            title: " البريد",
            onTap: () {
              cubit.changeSelectIndexBottom(index: 1); // استخدم الكيوبت مباشرة
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
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyScreen(),
                ),
              );
            },
          ),
          CustomDrawerTile(
            iconPath: AppAssets.shareIcon,
            title: "شارك مع الاصدقاء",
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
              await SecureStorageService.delete(SecureStorageService.email);
              await SecureStorageService.delete(SecureStorageService.mobile);
              await SecureStorageService.delete(SecureStorageService.name);
              await SecureStorageService.delete(SecureStorageService.customerid);
              await SecureStorageService.delete(SecureStorageService.token);
            },
          ),
          SizedBox(height: 25.h),
          Text(
              'تواصل معنا',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  cubit.whatsapp();
                },
                child: SvgPicture.asset(
                  AppAssets.whatsAppIcon,
                  width: 30.w,
                  height: 30.h,
                ),
              ),
              GestureDetector(
                onTap: () {
                  cubit.calling();
                },
                child: SvgPicture.asset(
                  AppAssets.phoneIcon,
                  width: 30.w,
                  height: 30.h,
                ),
              ),
            ],
          ),
          50.verticalSpace,

        ],
      ),
    );
  }
}
