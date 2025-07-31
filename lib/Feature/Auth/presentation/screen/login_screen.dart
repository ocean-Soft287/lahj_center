import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/Auth/presentation/screen/register_screen.dart';
import 'package:lahijcenter/core/constans/fonts.dart';
import 'package:lahijcenter/core/sharde/widget/navigation.dart';
import '../../../../core/Textstyle/text_style.dart';
import '../../../../core/constans/app_assets.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/responsve_font.dart';
import '../../../../core/sharde/widget/text_forn_field.dart';
import '../../../main/bottomNavbar/Bottomnav.dart';
import '../../manger/login-cubit/login_view_cubit.dart';
import '../../manger/login-cubit/login_view_state.dart';
import 'forgot_password_screen.dart';

var keyForm = GlobalKey<FormState>();
final emailController = TextEditingController();
final passwordController = TextEditingController();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<LoginViewCubit>(),
      child: BlocConsumer<LoginViewCubit, LoginViewState>(
        listener: (context, state) async {
if (state is LoginViewStateSuccess){
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => const Bottomnav()),
        (Route<dynamic> route) => false,
  );
}
//

        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                scrolledUnderElevation: 0,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.logo,
                        width: 100,
                        height: 100,
                      ),
                      30.verticalSpace,
                      Text(
                        'مرحبا بعودتك ! سعداء لرؤيتك مرة اخري',
                        style: Textstylefont.titlewelcome(context),
                      ),
                      30.verticalSpace,
                      CustomTextFormField(

                        hintText: "البريد الالكتروني",
                        validator: (value) {
                          if (value == null || value.isEmpty) return "برجاء إدخال رقم الهاتف";
                          if (value.length != 12) return "برجاء إدخال رقم الهاتف الصحيح";
                          return null;
                        },
                        controller: emailController,
                      ),
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
                          onPressed: () {
                            BlocProvider.of<LoginViewCubit>(context)
                                .changeIconPassword();
                          },
                          icon: Icon(
                            BlocProvider.of<LoginViewCubit>(context).subfix,
                            color: AppColors.mainAppColor,
                            size: 25.0,
                          ),
                        ),
                        textInputType: TextInputType.visiblePassword,
                        obscureText:
                            BlocProvider.of<LoginViewCubit>(context).isPassword,
                      ),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              BlocProvider.of<LoginViewCubit>(context).userLogin(password:passwordController.text, email: emailController.text,);

                              // navigato(context,
                              //     const HomeScreen());
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.mainAppColor,
                                    borderRadius: BorderRadius.circular(25)),
                                padding: const EdgeInsets.all(8),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "تسجيل الدخول",
                                        style: Textstylefont.logintext(context),
                                      ),
                                    ],
                                  ),
                                )),
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
                          )
                        ],
                      ),
                      50.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ليس لديك حساب ؟  ",
                            style: TextStyle(
fontFamily: Fonts.font,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: getFontSize(context, 14)),
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
                                  fontSize: getFontSize(context, 14)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
