import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/Auth/presentation/screen/verify_account_with_otp.dart';
import 'package:lahijcenter/core/constans/fonts.dart';

import '../../../../core/constans/app_assets.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/constants.dart';
import '../../../../core/constans/responsve_font.dart';
import '../../../../core/network/local/chachehelper.dart';
import '../../../../core/sharde/widget/navigation.dart';
import '../../../../core/sharde/widget/text_forn_field.dart';
import '../../manger/register_view_cubit/register_view_cubit.dart';
import '../../manger/register_view_cubit/register_view_state.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final keyForm = GlobalKey<FormState>();

  final phonecontroller = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final passwordController = TextEditingController();

  final firstNameController = TextEditingController();

  final lastNameController = TextEditingController();

  final emailController = TextEditingController();

  final activityController = TextEditingController();
  @override
  void dispose() {
    phonecontroller.dispose();
    confirmPasswordController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    activityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    currentLang = CacheHelper.getData(key: 'changeLang') ?? 'ar';

    return BlocProvider(
      create: (context) => GetIt.instance<RegisterViewCubit>(),
      child: BlocConsumer<RegisterViewCubit, RegisterViewState>(
        listener: (context, state) {
          if (state is RegisterViewStateSuccess) {
            navigato(context, OTPScreen(email: emailController.text));
          }
          if (state is RegisterViewStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("خطا في التسجيل"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<RegisterViewCubit>(context);

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              scrolledUnderElevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Form(
                  key: keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.logo, width: 70.w, height: 70.h),
                      10.verticalSpace,
                      Text(
                        "مرحبا! قم بالتسجيل للبدء",
                        style: TextStyle(
                          fontFamily: Fonts.font,
                          color: AppColors.secondAppColor,
                          fontWeight: FontWeight.w700,
                          fontSize: getFontSize(context, 24),
                        ),
                      ),
                      10.verticalSpace,

                      CustomTextFormField(
                        textInputType: TextInputType.text,
                        hintText: 'الاسم الأول',
                        validator: (value) => value == null || value.isEmpty
                            ? 'الرجاء إدخال الاسم الأول'
                            : null,
                        controller: firstNameController,
                      ),

                      CustomTextFormField(
                        textInputType: TextInputType.text,
                        hintText: 'اسم العائلة',
                        validator: (value) => value == null || value.isEmpty
                            ? 'الرجاء إدخال اسم العائلة'
                            : null,
                        controller: lastNameController,
                      ),

                      CustomTextFormField(
                        textInputType: TextInputType.emailAddress,
                        hintText: "البريد الإلكتروني",
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'الرجاء إدخال البريد الإلكتروني';
                          if (!value.contains("@") || !value.contains(".")) {
                            return "يرجى إدخال بريد إلكتروني صحيح";
                          }
                          return null;
                        },
                        controller: emailController,
                      ),
                      Align(
                        alignment: Alignment.topRight,

                        child: Text(
                          "البريد الإلكتروني يجب ان يتحوي علي @  ",
                          style: TextStyle(
                            fontFamily: Fonts.font,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: getFontSize(context, 8),
                          ),
                        ),
                      ),

                      CustomTextFormField(
                        textInputType: TextInputType.text,
                        hintText: 'النشاط',
                        validator: (value) => value == null || value.isEmpty
                            ? 'الرجاء إدخال النشاط'
                            : null,
                        controller: activityController,
                      ),

                      CustomTextFormField(
                        textInputType: TextInputType.phone,
                        hintText: 'رقم الجوال',
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "برجاء إدخال رقم الهاتف";
                          if (value.length != 12)
                            return "برجاء إدخال رقم الهاتف الصحيح";
                          return null;
                        },
                        controller: phonecontroller,
                      ),
                      Align(
                        alignment: Alignment.topRight,

                        child: Text(
                          "رقم الجوال يجب ألا يقل عن 12 رقم",
                          style: TextStyle(
                            fontFamily: Fonts.font,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: getFontSize(context, 8),
                          ),
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            hintText: "كلمة المرور",
                            textInputType: TextInputType.visiblePassword,
                            obscureText: cubit.isPassword,
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال كلمة المرور';
                              }
                              if (value.length < 8) {
                                return 'كلمة المرور يجب ألا تقل عن 8 أحرف';
                              }
                              if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                return 'يجب أن تحتوي على حرف كبير واحد على الأقل';
                              }
                              if (!RegExp(r'[a-z]').hasMatch(value)) {
                                return 'يجب أن تحتوي على حرف صغير واحد على الأقل';
                              }
                              if (!RegExp(r'[0-9]').hasMatch(value)) {
                                return 'يجب أن تحتوي على رقم واحد على الأقل';
                              }
                              if (!RegExp(
                                r'[!@#\$&*~%^()_+=\[\]{};:"\\|,.<>/?-]',
                              ).hasMatch(value)) {
                                return 'يجب أن تحتوي على رمز خاص واحد على الأقل';
                              }
                              if (confirmPasswordController.text.isNotEmpty &&
                                  confirmPasswordController.text != value) {
                                return 'كلمة المرور غير متطابقة مع التأكيد';
                              }
                              return null;
                            },
                            subfix: IconButton(
                              onPressed: cubit.changIconPassword,
                              icon: Icon(
                                cubit.subfix,
                                color: AppColors.mainAppColor,
                                size: 25.0,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "كلمة المرور يجب أن تحتوي على (A, a, 0, !@#...)",
                              style: TextStyle(
                                fontFamily: Fonts.font,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: getFontSize(context, 8),
                              ),
                            ),
                          ),
                        ],
                      ),

                      CustomTextFormField(
                        textInputType: TextInputType.visiblePassword,
                        hintText: 'تأكيد كلمة المرور',
                        obscureText: cubit.isPasswordConfirm,
                        subfix: IconButton(
                          onPressed: cubit.changIconPasswordConfirm,
                          icon: Icon(
                            cubit.subfixConfirm,
                            color: AppColors.mainAppColor,
                            size: 25.0,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'الرجاء تأكيد كلمة المرور';
                          if (value != passwordController.text) {
                            return "كلمة المرور غير متطابقة";
                          }
                          return null;
                        },
                        controller: confirmPasswordController,
                      ),


                      20.verticalSpace,

                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (keyForm.currentState!.validate()) {
                                cubit.registerUser(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phonecontroller.text,
                                  activity: activityController.text,
                                );
                              }
                            },
                            child: state is RegisterViewStateLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.mainAppColor,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.mainAppColor,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            'إنشاء حساب',
                                            style: TextStyle(
                                              fontFamily: Fonts.font,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: getFontSize(
                                                context,
                                                16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                          const Spacer(),
                        ],
                      ),

                      50.verticalSpace,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ليس لديك حساب؟  ',
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: getFontSize(context, 14),
                            ),
                          ),
                          InkWell(
                            onTap: () => navigato(context, const LoginScreen()),
                            child: Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontFamily: Fonts.font,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: getFontSize(context, 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                      50.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
