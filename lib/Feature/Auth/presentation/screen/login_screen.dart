import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lahijcenter/Feature/Auth/presentation/screen/register_screen.dart';
import 'package:lahijcenter/Feature/Auth/presentation/screen/verify_account_with_otp.dart';
import 'package:lahijcenter/Feature/licences/screen/privacy_policy.dart';
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
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Form(
                  key: keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.logo, width: 100.w, height: 100.h),
                      30.verticalSpace,
                      Text(
                        'مرحبا بعودتك ! سعداء لرؤيتك مرة اخري',
                        style: Textstylefont.titlewelcome(context),
                        textAlign: TextAlign.center,
                      ),
                      30.verticalSpace,

                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8.h, right: 4.w),
                          child: Row(
                            children: [
                              Icon(Icons.phone_android_outlined,color: AppColors.mainAppColor,),
                              SizedBox(
                                width: 10.w,
                              ),
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
                      SizedBox(
                        width: 10.w,
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
                            fontSize: 14.sp, // <--- تصغير حجم الرقم
                          ),

                          dropdownTextStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp, // <--- تصغير حجم كود الدولة في القائمة
                          ),



                          pickerDialogStyle: PickerDialogStyle(

                            countryCodeStyle: TextStyle(fontSize: 14.sp, color: Colors.black),
                            searchFieldInputDecoration: InputDecoration(

                              hintText: "ابحث عن الدوله ",
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.outline.withAlpha(80),
                                ),
                              ),
                            ),
                          ),

                          decoration: InputDecoration(
                            hintText: "XXX XXX XXX",
                            counterStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(borderSide: BorderSide()),
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



                      InkWell(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>PrivacyPolicyScreen()));

                        },
                        child:
        Center(child:
                        Text("الشروط والاحكام وسياسه الخصوصيه",
                        style: TextStyle(
                          color: AppColors.mainAppColor,
                          fontFamily: Fonts.font,
                          fontWeight: FontWeight.w700,
                          fontSize: getFontSize(context, 15),
                          decoration: TextDecoration.underline, // هنا الخط تحت النص


                        ),),
                      )),
                      SizedBox(height: 20.h,),



                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (keyForm.currentState!.validate()) {
                                  cubit.userLogin(
                                   // password: passwordController.text,
                                    phonenumber:  phoneController.text,
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
                      //     InkWell(
                      //       onTap: () {
                      //         navigato(context, const ForgotPasswordScreen());
                      //       },
                      //       child: Text(
                      //         "هل نسيت كلمه السر؟",
                      //         style: TextStyle(
                      //           fontFamily: Fonts.font,
                      //           color: AppColors.mainAppColor,
                      //           fontWeight: FontWeight.w500,
                      //           fontSize: getFontSize(context, 16),
                      //           decoration: TextDecoration.underline,
                      //           decorationColor: AppColors.mainAppColor,
                      //           decorationThickness: 2,
                      //         ),
                      //       ),
                      //     ),
                         ],
                       ),

                       50.verticalSpace,
                      //
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       "ليس لديك حساب ؟  ",
                      //       style: TextStyle(
                      //         fontFamily: Fonts.font,
                      //         color: Colors.black,
                      //         fontWeight: FontWeight.w500,
                      //         fontSize: getFontSize(context, 14),
                      //       ),
                      //     ),
                      //     InkWell(
                      //       onTap: () {
                      //         navigato(context, RegisterScreen());
                      //       },
                      //       child: Text(
                      //         "انشاء حساب",
                      //         style: TextStyle(
                      //           fontFamily: Fonts.font,
                      //           color: AppColors.mainAppColor,
                      //           fontWeight: FontWeight.w500,
                      //           fontSize: getFontSize(context, 14),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
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