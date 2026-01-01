import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lahijcenter/Feature/Auth/presentation/screen/verify_account_with_otp.dart';
import 'package:lahijcenter/Feature/licences/screen/privacy_policy.dart';
import 'package:lahijcenter/core/constans/fonts.dart';
import '../../../../core/Textstyle/text_style.dart';
import '../../../../core/constans/app_assets.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/responsve_font.dart';
import '../../../../core/network/local/flutter_secure_storage.dart';
import '../../manger/login-cubit/login_view_cubit.dart';
import '../../manger/login-cubit/login_view_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final keyForm = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
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
             ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.white),
                                SizedBox(width: 12.w),
                                Text("من فضلك راجع واتساب، تم إرسال رمز التحقق على رقمك ",
                                    style: TextStyle(color: Colors.white,
                                    fontSize: 10.sp)),
                              ],
                            ),
                            backgroundColor: AppColors.mainAppColor,
                            duration: Duration(seconds: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: EdgeInsets.all(16),
                          ),
                        );
                        

            Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                builder: (context) => OTPScreen(
                  phonenumber: phoneController.text,
                ),
              ),
                  (Route<dynamic> route) => false,
            );
          }

          if (state is LoginViewStateError) {
            String serverMessage = state.failure.message;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(serverMessage, style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.red,
              ),
            );
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
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: SingleChildScrollView(
                child: Form(
                  key: keyForm,
                  child: Column(

                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: Colors.white,
                          border: Border.all(
                            color: AppColors.mainAppColor.withValues(alpha:0.1),
                            width: 1,
                          ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]



                        ),
                        child: Image.asset(
                          AppAssets.logo,
                          width: 100.w,
                          height: 100,
                        ),
                      ),
                      30.verticalSpace,
                      Text(
                        'مرحبا بعودتك ! سعداء لرؤيتك مرة اخري',
                        style: Textstylefont.titlewelcome(context),
                        textAlign: TextAlign.center,
                      ),
                      30.verticalSpace,


                      Card(
                        elevation: 4,
                        shadowColor: AppColors.mainAppColor.withValues(alpha:0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: AppColors.mainAppColor.withValues(alpha:0.1),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 12.h, right: 4.w),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.phone_android_outlined,
                                        color: AppColors.mainAppColor,
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        'رقم الجوال',
                                        style: TextStyle(
                                          fontFamily: Fonts.font,
                                          fontSize: getFontSize(context, 15),
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: IntlPhoneField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                  dropdownTextStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                  pickerDialogStyle: PickerDialogStyle(
                                    countryCodeStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.black,
                                    ),
                                    searchFieldInputDecoration: InputDecoration(
                                      hintText: "ابحث عن الدوله ",
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 16,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline
                                              .withAlpha(80),
                                        ),
                                      ),
                                    ),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "XXX XXX XXX",
                                    counterStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  initialCountryCode: 'EG',
                                  onChanged: (phone) {
                                    phoneController.text = phone.completeNumber;
                                  },
                                  validator: (value) {
                                    if (value == null || value.number.isEmpty) {
                                      return "LocaleKeys.phone_number_required.tr()";
                                    }
                                    try {
                                      if (!value.isValidNumber()) {
                                        return "LocaleKeys.phone_number_invalid.tr()";
                                      }
                                    } catch (e) {
                                      return "LocaleKeys.phone_number_invalid.tr()";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => PrivacyPolicyScreen(),
                            ),
                          );
                        },
                        child: Center(
                          child: Text(
                            "الشروط والاحكام وسياسه الخصوصيه",
                            style: TextStyle(
                              color: AppColors.mainAppColor,
                              fontFamily: Fonts.font,
                              fontWeight: FontWeight.w700,
                              fontSize: getFontSize(context, 15),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (phoneController.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "من فضلك قم بتسجيل الدخول بإدخال رقم الجوال",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  return;
                                }

                                cubit.userLogin(
                                  phonenumber: phoneController.text,
                                );
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
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                padding: EdgeInsets.all(8.w),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "تسجيل الدخول",
                                        style: Textstylefont.logintext(
                                          context,
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 20.sp,
                                      ),
                                    ],
                                  ),
                                ),
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