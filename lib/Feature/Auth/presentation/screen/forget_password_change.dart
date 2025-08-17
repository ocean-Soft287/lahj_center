import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/constans/app_assets.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/fonts.dart';
import '../../../../core/constans/responsve_font.dart';
import '../../../../core/network/local/flutter_secure_storage.dart';
import '../../../../core/sharde/widget/default_button.dart';
import '../../../../core/sharde/widget/text_forn_field.dart';
import '../../../main/bottomNavbar/Bottomnav.dart';
import '../../manger/login-cubit/login_view_cubit.dart';
import '../../manger/login-cubit/login_view_state.dart';
import 'login_screen.dart';

var keyForm = GlobalKey<FormState>();

final passwordController = TextEditingController();
final passwordControllerConfirm = TextEditingController();
final codeController = TextEditingController();

class ForgetPasswordChange extends StatefulWidget {
  const ForgetPasswordChange({super.key, required this.email, required this.name});
  final String email;
  final String name;

  @override
  State<ForgetPasswordChange> createState() => _ForgetPasswordChangeState();
}

class _ForgetPasswordChangeState extends State<ForgetPasswordChange> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<LoginViewCubit>(),
      child: BlocConsumer<LoginViewCubit, LoginViewState>(
        listener: (context, state) {
          if (state is ForgetandchangepassSuccessMessage && widget.name == 'forgetpassword') {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
            );
          } else if (state is ForgetandchangepassSuccessMessage && widget.name == 'change') {
            SecureStorageService.write(SecureStorageService.password, passwordController.text);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Bottomnav()),
                  (route) => false,
            );
          }
          if (state is LoginViewStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("خطا في التسجيل"),
                backgroundColor: Colors.red,
              ),
            );
          }
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
                child: Form(
                  key: keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Image.asset(AppAssets.forgotPassword)),
                      30.verticalSpace,
                      Text(
                        "updatepassword".tr(),
                        style: TextStyle(
                          fontFamily: Fonts.font,
                          color: AppColors.secondAppColor,
                          fontWeight: FontWeight.w700,
                          fontSize: getFontSize(context, 24),
                        ),
                      ),
                      20.verticalSpace,
                      CustomTextFormField(
                        hintText: "كود لإعادة تعيين كلمة المرور",
                        controller: codeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال الكود';
                          }
                          return null;
                        },
                        textInputType: TextInputType.text,
                      ),
                      20.verticalSpace,
                      CustomTextFormField(
                        hintText: "كلمة السر الجديدة",
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please_enter_password'.tr();
                          }
                          return null;
                        },
                        subfix: IconButton(
                          onPressed: () {
                            BlocProvider.of<LoginViewCubit>(context).changeIconPassword();
                          },
                          icon: Icon(
                            BlocProvider.of<LoginViewCubit>(context).subfix,
                            color: AppColors.mainAppColor,
                            size: 25.0,
                          ),
                        ),
                        textInputType: TextInputType.visiblePassword,
                        obscureText: BlocProvider.of<LoginViewCubit>(context).isPassword,
                      ),
                      20.verticalSpace,
                      CustomTextFormField(
                        hintText: "تأكيد كلمة السر الجديدة",
                        controller: passwordControllerConfirm,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please_enter_password'.tr();
                          } else if (value != passwordController.text) {
                            return 'كلمة السر غير متطابقة';
                          }
                          return null;
                        },
                        subfix: IconButton(
                          onPressed: () {
                            BlocProvider.of<LoginViewCubit>(context).changeIconPassword();
                          },
                          icon: Icon(
                            BlocProvider.of<LoginViewCubit>(context).subfix,
                            color: AppColors.mainAppColor,
                            size: 25.0,
                          ),
                        ),
                        textInputType: TextInputType.visiblePassword,
                        obscureText: BlocProvider.of<LoginViewCubit>(context).isPassword,
                      ),

                      20.verticalSpace,
                      Align(
  alignment: Alignment.bottomCenter,
  child: state is ForgetpasswordLoading
      ?  CircularProgressIndicator(color: AppColors.mainAppColor)
      : DefaultButton(
          function: () {
            if (keyForm.currentState!.validate()) {
              BlocProvider.of<LoginViewCubit>(context).forgetandchangepass(
                email: widget.email,
                token: codeController.text,
                newpass: passwordController.text,
              );
            }
          },
          text: "تحديث",
        ),
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
