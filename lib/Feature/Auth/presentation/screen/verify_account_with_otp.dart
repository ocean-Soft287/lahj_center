import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/Auth/manger/register_view_cubit/register_view_cubit.dart';
import 'package:lahijcenter/Feature/Auth/manger/register_view_cubit/register_view_state.dart';
import 'package:lahijcenter/Feature/Auth/presentation/screen/register_screen.dart';
import 'package:lahijcenter/core/constans/app_assets.dart';
import 'package:lahijcenter/core/constans/app_colors.dart';
import 'package:lahijcenter/core/constans/constants.dart';
import 'package:lahijcenter/core/constans/fonts.dart';
import 'package:lahijcenter/core/constans/responsve_font.dart';

import '../../../../core/network/local/chachehelper.dart';
import '../../../../core/sharde/widget/navigation.dart';
import '../widget/otp_component.dart';
import 'login_screen.dart';

class OTPScreen extends StatefulWidget {
  final String  phonenumber;

  const OTPScreen({super.key, required this.phonenumber});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final keyForm = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String getEnteredOTP() {
    return _otpControllers.map((e) => e.text).join();
  }

  @override
  Widget build(BuildContext context) {
    currentLang = CacheHelper.getData(key: 'changeLang') ?? 'ar';

    return BlocProvider(
      create: (context) => GetIt.instance<RegisterViewCubit>(),
      child: BlocConsumer<RegisterViewCubit, RegisterViewState>(
        listener: (context, state) {
          if (state is otpError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is otpSuccess) {
            navigatofinsh(context,  RegisterScreen(
              phoneNumber: widget.phonenumber,

            ),true);
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
                      Image.asset(
                        AppAssets.logo,
                        width: 70.w,
                        height: 70.h,
                      ),
                      10.verticalSpace,
                      Text(
                        " كود التحقق",
                        style: TextStyle(
                          fontFamily: Fonts.font,
                          color: AppColors.secondAppColor,
                          fontWeight: FontWeight.w700,
                          fontSize: getFontSize(context, 24),
                        ),
                      ),
                      10.verticalSpace,
                      Text(
"لقد ارسلنا كود التحقق المكون من ٦ أرقام الي رقم الهاتف" ,                       style: TextStyle(
                          fontFamily: Fonts.font,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                          fontSize: getFontSize(context, 16),
                        ),
                      ),
                      20.verticalSpace,
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(6, (index) {
                            return OtpInput(controller: _otpControllers[index]);
                          }),
                        ),
                      ),
                      40.verticalSpace,


                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: state is otpLoading
                              ? null
                              : () {
                                  if (keyForm.currentState!.validate()) {
                                    final otp = getEnteredOTP();
                                    cubit.verifotp(
                                      otp: otp,
                                      phoneNumber: widget.phonenumber,
                                    );
                                   // print("OTP Entered: $otp");
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainAppColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: state is otpLoading
                              ? const SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'تأكيد الكود',
                                  style: TextStyle(
                                    fontFamily: Fonts.font,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: getFontSize(context, 16),
                                  ),
                                ),
                        ),
                      ),
                      50.verticalSpace,

                      /// Back to login
                      // TextButton(
                      //   onPressed: () {
                      //     Navigator.pushAndRemoveUntil(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => const LoginScreen()),
                      //       (route) => false,
                      //     );
                      //   },
                      //   child: Text(
                      //     'الرجوع لتسجيل الدخول',
                      //     style: TextStyle(
                      //       fontFamily: Fonts.font,
                      //       fontSize: getFontSize(context, 14),
                      //       color: Colors.grey[600],
                      //     ),
                      //   ),
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
