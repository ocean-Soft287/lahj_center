import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lahijcenter/Feature/Auth/presentation/screen/login_screen.dart';
import 'package:lahijcenter/Feature/profile/data/models/deleate_account_model.dart';
import 'package:lahijcenter/Feature/profile/manager/deleate_account_cubit.dart';
import 'package:lahijcenter/core/bloc/base_state.dart';
import 'package:lahijcenter/core/constans/app_colors.dart';
import 'package:lahijcenter/Feature/profile/manager/update_profile_cubit.dart';
import 'package:lahijcenter/Feature/profile/manager/update_profile_state.dart';
import 'package:lahijcenter/Feature/profile/manager/get_profile_cubit.dart';
import 'package:lahijcenter/Feature/profile/manager/get_profile_state.dart';
import 'package:lahijcenter/core/constans/fonts.dart';
import 'package:lahijcenter/core/sharde/widget/text_forn_field.dart';

import 'new_password_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  File? selectedImage;
  String? imageBase64;

  late final GetProfileCubit getProfileCubit;
  late final UpdateProfileCubit updateProfileCubit;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        selectedImage = File(pickedFile.path);
        imageBase64 = base64Encode(bytes);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProfileCubit = GetIt.instance<GetProfileCubit>();
    updateProfileCubit = GetIt.instance<UpdateProfileCubit>();
    getProfileCubit.fetchProfile();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getProfileCubit),
        BlocProvider.value(value: updateProfileCubit),
        
      
        
      ],
      child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) async {
          if (state is UpdateProfileSuccess) {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("تم التحديث بنجاح "),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.all(16),
              ),
            );

            await getProfileCubit.fetchProfile();

          } else if (state is UpdateProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("خطأ: ${state.message}"),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.all(16),
              ),
            );
          }
        },
        child: BlocBuilder<GetProfileCubit, GetProfileState>(
          builder: (context, state) {
            if (state is GetProfileLoading) {
              return Scaffold(
                backgroundColor: Colors.grey[50],
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.mainAppColor,
                        ),
                        strokeWidth: 3,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "جاري تحميل البيانات...",
                        style: TextStyle(
                          color: AppColors.mainAppColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is GetProfileSuccess) {
              final profile = state.profile;

              nameController.text = profile.firstName;
              emailController.text = profile.email;
              phoneController.text = profile.phoneNumber.toString();

              return Scaffold(
                backgroundColor: Colors.grey[50],
                appBar: AppBar(

                  title: Text(
                    "تعديل الملف الشخصي",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: AppColors.mainAppColor,
                  elevation: 0,
                  centerTitle: true,
                  iconTheme: IconThemeData(color: Colors.white),
                ),
                body: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.mainAppColor.withValues(alpha:0.05),
                        Colors.grey[50]!,
                      ],
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha:0.08),
                                blurRadius: 20,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.mainAppColor
                                                .withValues(alpha:0.2),
                                            blurRadius: 15,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundColor: AppColors.mainAppColor
                                            .withValues(alpha:0.1),
                                        backgroundImage: selectedImage != null
                                            ? FileImage(selectedImage!)
                                            : (profile.imageUrl != null &&
                                                          profile
                                                              .imageUrl!
                                                              .isNotEmpty
                                                      ? NetworkImage(
                                                          profile.imageUrl!,
                                                        )
                                                      : const AssetImage(
                                                          "assets/images/default_user.png",
                                                        ))
                                                  as ImageProvider,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: pickImage,
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: AppColors.mainAppColor,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.mainAppColor
                                                  .withValues(alpha:0.4),
                                              blurRadius: 8,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "تعديل الصورة الشخصية",
                                  style: TextStyle(
                                    color: AppColors.mainAppColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha:0.08),
                                blurRadius: 20,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              buildLabel("الاسم"),
                              SizedBox(height: 8),
                              CustomTextFormField(controller: nameController),
                              const SizedBox(height: 20),
                              buildLabel("البريد الإلكتروني"),
                              SizedBox(height: 8),
                              CustomTextFormField(controller: emailController),
                              const SizedBox(height: 20),
                              buildLabel("رقم الهاتف"),
                              SizedBox(height: 8),
                              CustomTextFormField(controller: phoneController),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha:0.08),
                                blurRadius: 20,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PasswordUpdateScreen(),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: AppColors.mainAppColor
                                                      .withValues(alpha:0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Icon(
                                                  Icons.lock_outline,
                                                  color: AppColors.mainAppColor,
                                                  size: 20,
                                                ),
                                              ),
                                              SizedBox(width: 12),
                                              Text(
                                                "تغيير كلمة المرور",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: Fonts.font,
                                                  color: Colors.grey[800],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.grey[400],
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Divider(height: 1, color: Colors.grey[200]),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      title: Row(
                                        children: [
                                          Icon(
                                            Icons.warning_amber_rounded,
                                            color: Colors.red,
                                            size: 24,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'تأكيد الحذف',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: Text(
                                        'هل أنت متأكد أنك تريد حذف الحساب؟',
                                        style: TextStyle(
                                          fontSize: 16,
                                          height: 1.5,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            'إلغاء',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                       BlocConsumer<DeleateAccountCubit, BaseState<DeleateAccountModel>>(
  listener: (context, state) {
    if (state.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("تم حذف الحساب بنجاح"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
        (route) => false,
      );
    } else if (state.isFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("حدث خطأ أثناء حذف الحساب"),
          backgroundColor: Colors.red,
        ),
      );
    }
  },
  builder: (context, state) {
    return ElevatedButton(
      onPressed: () {
        context.read<DeleateAccountCubit>().deleteAccount(
              profile.id.toString(),
            );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: state.isLoading
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.mainAppColor,
              ),
            )
          : const Text(
              'حذف',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  },
),

                                      ],
                                    ),
                                  ),
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(20),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.red.withValues(alpha:
                                                  0.1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Icon(
                                                Icons.delete_outline,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                            ),
                                            SizedBox(width: 12),
                                            Text(
                                              "حذف الحساب",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.grey[400],
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        const SizedBox(height: 30),
                        BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                          builder: (context, updateState) {
                            return Container(
                              width: double.infinity,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.mainAppColor.withValues(alpha:
                                      0.3,
                                    ),
                                    blurRadius: 15,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: updateState is UpdateProfileLoading
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.mainAppColor
                                            .withValues(alpha:0.7),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Center(
                                        child: SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                            strokeWidth: 3,
                                          ),
                                        ),
                                      ),
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.mainAppColor,
                                        minimumSize: const Size.fromHeight(45),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      onPressed: () {
                                        updateProfileCubit.updateProfile(
                                          name: nameController.text,
                                          email: emailController.text,
                                          phone: phoneController.text,
                                          imageBase64: imageBase64,
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.save_outlined,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            "حفظ",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Scaffold(
                backgroundColor: Colors.grey[50],
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red[400],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "حدث خطأ في تحميل البيانات",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => getProfileCubit.fetchProfile(),
                        icon: Icon(Icons.refresh),
                        label: Text("إعادة المحاولة"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainAppColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildLabel(String text) => Align(
    alignment: Alignment.centerRight,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.grey[700],
      ),
    ),
  );
}
