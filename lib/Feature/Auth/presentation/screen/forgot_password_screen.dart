import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/core/constans/fonts.dart';
import 'package:lahijcenter/core/constans/responsve_font.dart';
import 'package:lahijcenter/core/sharde/widget/navigation.dart';

import '../../../../../core/constans/app_assets.dart';
import '../../../../../core/constans/app_colors.dart';

import '../../../../../core/sharde/widget/text_forn_field.dart';
import '../../manger/login-cubit/login_view_cubit.dart';
import '../../manger/login-cubit/login_view_state.dart';
import 'forget_password_change.dart';

var keyForm = GlobalKey<FormState>();
final emailcontroller = TextEditingController();

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<LoginViewCubit>(),
      child: BlocConsumer<LoginViewCubit,LoginViewState>(
        listener: (context,state)  {


       if(state is LoginViewStateSuccessMessage ){

       navigato(context,  ForgetPasswordChange(name:  'forgetpassword', email: emailcontroller.text));



      }
      if(state is LoginViewStateError){
         ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("خطا في التسجيل "),
                backgroundColor: Colors.red,
              ),
            );
      }},

        builder: (context,state){

          LoginViewCubit loginViewCubit=BlocProvider.of(context);
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                scrolledUnderElevation: 0,
              ),
              body: Padding(

                padding:const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                  
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Image.asset(AppAssets.forgotPassword)),

                      30.verticalSpace,
                      Text('forgot_password'.tr(),style: TextStyle(
                          color: AppColors.secondAppColor,
fontFamily: Fonts.font,
                          fontWeight: FontWeight.w700,
                          fontSize: getFontSize(context,24)
                      ),),
                  
                      CustomTextFormField(
                        hintText: 'البريد الالكتروني',
                        validator: (value) {
                  
                          if (value == null || value.isEmpty) {
                            return 'please_enter_email'.tr();
                          }
                  
                  
                  
                  
                          return null;
                        },
                        controller: emailcontroller,
                      ),
                    
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         GestureDetector(
  onTap: () {
    if (keyForm.currentState!.validate()) {
      loginViewCubit.forgetPassword(email: emailcontroller.text);
    }
  },
  child: state is LoginViewStateLoading
      ?  Center(
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
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                const Icon(Icons.arrow_back, color: Colors.white),
                const SizedBox(width: 5),
                Text(
                  'send_code'.tr(),
                  style: TextStyle(
                    fontFamily: Fonts.font,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: getFontSize(context, 16),
                  ),
                ),
              ],
            ),
          ),
        ),
),

                         const Spacer()
                  
                        ],
                      ),
                  
                  
                    ],
                  ),
                ),
              )
          );
        },

      ),
    );
  }
}