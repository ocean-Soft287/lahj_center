import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/Auth/presentation/screen/register_screen.dart';
import 'package:lahijcenter/Feature/Auth/presentation/screen/verify_account_with_otp.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/constans/fonts.dart';
import 'package:lahijcenter/core/sharde/widget/navigation.dart';
import '../../../../core/Textstyle/text_style.dart';
import '../../../../core/constans/app_assets.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/responsve_font.dart';
import '../../../../core/network/local/flutter_secure_storage.dart';
import '../../../../core/sharde/widget/text_forn_field.dart';
import '../../../main/bottomNavbar/Bottomnav.dart';
import '../../manger/login-cubit/login_view_cubit.dart';
import '../../manger/login-cubit/login_view_state.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final keyForm = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<LoginViewCubit>(),
      child: BlocConsumer<LoginViewCubit, LoginViewState>(
        listener: (context, state) async {
          if (state is LoginViewStateSuccess) {
            final user = state.dataUser;

            await SecureStorageService.write(
              SecureStorageService.token,
              user.token,
            );
            await SecureStorageService.write(
              SecureStorageService.email,
              user.email,
            );
            await SecureStorageService.write(
              SecureStorageService.name,
              '${user.firstName} ${user.lastName}',
            );
            await SecureStorageService.write(
              SecureStorageService.image,
              user.imageUrl,
            );
            await SecureStorageService.write(
              SecureStorageService.mobile,
              user.phoneNumber,
            );

            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Bottomnav()),
              (Route<dynamic> route) => false,
            );
          }
          if (state is LoginViewStateError) {
            if (state.failure is VerifyOtpFailure) {
              navigato(
                context,
                OTPScreen(email: emailController.text),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("خطا في كلمه كلمه المرور او البريد الالكتروني"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<LoginViewCubit>(context);
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.logo, width: 100, height: 100),
                      30.verticalSpace,
                      Text(
                        'مرحبا بعودتك ! سعداء لرؤيتك مرة اخري',
                        style: Textstylefont.titlewelcome(context),
                      ),
                      30.verticalSpace,

                      /// Email
                      CustomTextFormField(
                        hintText: "البريد الالكتروني",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "الرجاء إدخال البريد الإلكتروني";
                          }
                          if (!value.contains("@") || !value.contains(".")) {
                            return "يرجى إدخال بريد إلكتروني صحيح";
                          }
                          return null;
                        },
                        controller: emailController,
                      ),

                      /// Password
                      CustomTextFormField(
                        hintText: "كلمه المرور",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please_enter_password'.tr();
                          }
                          return null;
                        },
                        controller: passwordController,
                        subfix: IconButton(
                          onPressed: () => cubit.changeIconPassword(),
                          icon: Icon(
                            cubit.subfix,
                            color: AppColors.mainAppColor,
                            size: 25.0,
                          ),
                        ),
                        textInputType: TextInputType.visiblePassword,
                        obscureText: cubit.isPassword,
                      ),
                      20.verticalSpace,

                      /// Login Button + Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              if (keyForm.currentState!.validate()) {
                                cubit.userLogin(
                                  password: passwordController.text,
                                  email: emailController.text,
                                );
                              }
                            },
                            child: state is LoginViewStateLoading
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
                                            "تسجيل الدخول",
                                            style: Textstylefont.logintext(
                                              context,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                          InkWell(
                            onTap: () {
                              navigato(context, const ForgotPasswordScreen());
                            },
                            child: Text(
                              "هل نسيت كلمه السر؟",
                              style: TextStyle(
                                fontFamily: Fonts.font,
                                color: AppColors.mainAppColor,
                                fontWeight: FontWeight.w500,
                                fontSize: getFontSize(context, 16),
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.green,
                                decorationThickness: 2,
                              ),
                            ),
                          ),
                        ],
                      ),

                      50.verticalSpace,

                      /// Register Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ليس لديك حساب ؟  ",
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: getFontSize(context, 14),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              navigato(context, RegisterScreen());
                            },
                            child: Text(
                              "انشاء حساب",
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
