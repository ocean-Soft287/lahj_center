import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/Auth/presentation/screen/login_screen.dart';
import 'package:lahijcenter/Feature/profile/screen/widget/show_dialog_delete_account.dart';
import 'package:lahijcenter/core/constans/app_assets.dart';
import '../../../../../core/constans/app_colors.dart';
import '../../../../../core/constans/fonts.dart';
import '../../../../../core/constans/responsve_font.dart';
import '../../../../../core/sharde/widget/text_forn_field.dart';
import '../../../core/network/local/flutter_secure_storage.dart';
import '../../Auth/manger/login-cubit/login_view_cubit.dart';
import '../../Auth/presentation/screen/forget_password_change.dart';
import '../manager/profile_cubit.dart';
import '../manager/profile_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  String? phone;
  String? email;
  String? password;
  int? customerId;
  String? profileImage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final name = await SecureStorageService.read(SecureStorageService.name);
    phone = await SecureStorageService.read(SecureStorageService.mobile);
    email = await SecureStorageService.read(SecureStorageService.email);
    password = await SecureStorageService.read(SecureStorageService.password);
    final id = await SecureStorageService.read(SecureStorageService.customerid);
    profileImage = await SecureStorageService.read(SecureStorageService.image);
    setState(() {
      nameController.text = name ?? '';
      customerId = int.tryParse(id ?? '');
      isLoading = false;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileViewCubit>(
          create: (context) => GetIt.instance<ProfileViewCubit>(),
        ),
        BlocProvider<LoginViewCubit>(
          create: (context) => GetIt.instance<LoginViewCubit>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "تعديل الملف الشخصي",
            style: TextStyle(
              fontFamily: Fonts.font,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: getFontSize(context, 15),
            ),
          ),
          actions: [
            BlocBuilder<ProfileViewCubit, ProfileViewState>(
              builder: (context, state) {
                return TextButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    if (name.isEmpty ||
                        phone == null ||
                        email == null ||
                        customerId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("البيانات ناقصة")),
                      );
                      return;
                    }

                    context.read<ProfileViewCubit>().submitProfileEdit(
                      customerId: customerId!,
                      arabicName: name,
                      englishName: name,
                      phone: phone!,
                      password: password.toString(),
                      email: email!,
                    );
                  },
                  child: Text(
                    "حفظ",
                    style: TextStyle(
                      fontFamily: Fonts.font,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: getFontSize(context, 15),
                    ),
                  ),
                );
              },
            ),
          ],
          backgroundColor: AppColors.mainAppColor,
          elevation: 0,
        ),
        body:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : BlocConsumer<ProfileViewCubit, ProfileViewState>(
                  listener: (context, state) async {
                    if (state is EditProfileSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("تم التعديل بنجاح")),
                      );

                      // إعادة تسجيل الدخول تلقائياً
                      final phone = await SecureStorageService.read(
                        SecureStorageService.mobile,
                      );
                      final password = await SecureStorageService.read(
                        SecureStorageService.password,
                      );

                      if (context.mounted) {
                        final loginCubit = GetIt.instance<LoginViewCubit>();
                        // loginCubit.userLogin(
                        //   customerPhone: phone ?? '',
                        //   password: password ?? '',
                        // );
                      }
                    } else if (state is DeleteProfileSuccessState) {
                      SecureStorageService.delete(
                        SecureStorageService.customerid,
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    final cubit = context.read<ProfileViewCubit>();

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Center(
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 50.sp,
                                  backgroundImage:
                                      cubit.imageEditProfilePhoto != null
                                          ? FileImage(
                                            File(
                                              cubit.imageEditProfilePhoto!.path,
                                            ),
                                          )
                                          : NetworkImage(
                                                profileImage == null ||
                                                        profileImage!.isEmpty
                                                    ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
                                                    : "http://78.89.159.126:9393/TheOneLahjAPI/CustomerImages/$profileImage",
                                              )
                                              as ImageProvider,
                                ),
                                InkWell(
                                  onTap: cubit.getProfileImageByGallery,
                                  child: SvgPicture.asset(
                                    AppAssets.editImageIcon,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "تعديل الصورة الشخصية",
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  color: AppColors.mainAppColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: getFontSize(context, 15),
                                ),
                              ),
                              SizedBox(width: 10.w),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          CustomTextFormField(
                            controller: nameController,
                            hintText: 'gamal',
                          ),
                          SizedBox(height: 20.h),
                          const Divider(),
                          ListTile(
                            title: Text(
                              "تغيير كلمة المرور",
                              style: TextStyle(
                                fontFamily: Fonts.font,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: getFontSize(context, 16),
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.mainAppColor,
                            ),
                            onTap: () async {
                              final mobile = await SecureStorageService.read(
                                SecureStorageService.mobile,
                              );
                              // if (!context.mounted) return;
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder:
                              //         (_) => ForgetPasswordChange(
                              //           number: mobile.toString(),
                              //           name: 'change',
                              //         ),
                              //   ),
                              // );
                            },
                          ),
                          ListTile(
                            title: Text(
                              "حذف الحساب",
                              style: TextStyle(
                                fontFamily: Fonts.font,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: getFontSize(context, 16),
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.mainAppColor,
                            ),
                            onTap: () {
                              showdeleteaccountdialog(
                                context,
                                onDelete: () => cubit.deleteuser(),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
