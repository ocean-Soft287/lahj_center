import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/core/constans/fonts.dart';
import '../../../../core/constans/app_assets.dart';
import '../../../../core/constans/app_colors.dart';
import '../../../../core/constans/constants.dart';
import '../../../../core/constans/responsve_font.dart';
import '../../../../core/network/local/chachehelper.dart';
import '../../../../core/sharde/widget/navigation.dart';
import '../../../../core/sharde/widget/text_forn_field.dart';
import '../../../main/bottomNavbar/Bottomnav.dart';
import '../../manger/register_view_cubit/register_view_cubit.dart';
import '../../manger/register_view_cubit/register_view_state.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {
  final String phoneNumber;

  RegisterScreen({super.key, required this.phoneNumber});

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
  final genderController = TextEditingController();

  String? selectedGender;
  String? selectedActivity;

  @override
  void dispose() {
    phonecontroller.dispose();
    confirmPasswordController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    genderController.dispose();
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
            navigato(context, Bottomnav());
          }
          if (state is RegisterViewStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
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

                          child: Image.asset(AppAssets.logo, width:100.w, height: 100.h)),
                      10.verticalSpace,
                      Text(
                        "اكمال بيانات الحساب",
                        style: TextStyle(
                          fontFamily: Fonts.font,
                          color: AppColors.mainAppColor,
                          fontWeight: FontWeight.w700,
                          fontSize: getFontSize(context, 24),
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                      "املأ البيانات ادناه للانضمام الينا",
                        style: TextStyle(
                          fontFamily: Fonts.font,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w500,
                          fontSize: getFontSize(context, 15),
                        ),
                      ),
                      10.verticalSpace,
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.mainAppColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            _buildSectionHeader(
                              'البيانات الأساسية',
                              Icons.person,
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    textInputType: TextInputType.text,
                                    prefix: Icon(
                                      Icons.person,
                                      color: AppColors.mainAppColor,
                                    ),
                                    hintText: 'الاسم الاول',
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                        ? 'الرجاء إدخال الاسم الأول'
                                        : null,
                                    controller: firstNameController,
                                  ),
                                ),
                                10.horizontalSpace,
                                Expanded(
                                  child: CustomTextFormField(
                                    textInputType: TextInputType.text,
                                    prefix: Icon(
                                      Icons.person,
                                      color: AppColors.mainAppColor,
                                    ),
                                    hintText: 'الاسم الاخير',
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                        ? 'الرجاء إدخال اسم العائلة'
                                        : null,
                                    controller: lastNameController,
                                  ),
                                ),
                              ],
                            ),

                            DropdownButtonFormField<String>(
                              value: selectedActivity,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.5,
                                  ),
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AppColors.mainAppColor,
                                    width: 2,
                                  ),
                                ),
                                hintText: 'اختر النشاط',
                                hintStyle: TextStyle(
                                  fontFamily: Fonts.font,
                                  color: Colors.grey,
                                ),
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.mainAppColor,
                              ),
                              validator: (value) =>
                                  value == null ? 'الرجاء اختيار النشاط' : null,
                              items: ['فرد', 'أسر منتجة', 'تاجر'].map((
                                String activity,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: activity,
                                  child: Text(
                                    activity,
                                    style: TextStyle(
                                      fontFamily: Fonts.font,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedActivity = newValue;
                                });
                              },
                            ),
                            SizedBox(height: 15.h),

                            DropdownButtonFormField<String>(
                              value: selectedGender,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: AppColors.mainAppColor, width: 2),
                                ),
                                hintText: 'اختر الجنس',
                                hintStyle: TextStyle(fontFamily: Fonts.font, color: Colors.grey),
                              ),
                              icon: Icon(Icons.keyboard_arrow_down, color: AppColors.mainAppColor),
                              validator: (value) => value == null ? 'الرجاء اختيار الجنس' : null,
                              items: ['ذكر', 'أنثى'].map((String gender) {
                                return DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(gender, style: TextStyle(fontFamily: Fonts.font, color: Colors.black)),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedGender = newValue;
                                  genderController.text = newValue ?? '';
                                });
                              },
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            _buildSectionHeader('معلومات الاتصال', Icons.phone),

                            CustomTextFormField(
                              textInputType: TextInputType.emailAddress,
                              prefix: Icon(
                                Icons.email_outlined,
                                color: AppColors.mainAppColor,
                              ),

                              hintText: "البريد الإلكتروني",
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return 'الرجاء إدخال البريد الإلكتروني';
                                if (!value.contains("@") ||
                                    !value.contains(".")) {
                                  return "يرجى إدخال بريد إلكتروني صحيح";
                                }
                                return null;
                              },
                              controller: emailController,
                            ),

                            CustomTextFormField(
                              readOnly: true,
textDirection: TextDirection.rtl,
                              hintText: widget.phoneNumber,


                              prefix: Icon(
                                Icons.phone,
                                color: AppColors.mainAppColor,
                              ),



                              controller: phonecontroller,
                              textInputType: TextInputType.phone,
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.digitsOnly,
                              //   LengthLimitingTextInputFormatter(9),
                              // ],
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return "برجاء إدخال رقم الهاتف";
                              //   }
                              //   if (value.length != 9) {
                              //     return "رقم الجوال يجب أن يكون مكونًا من 9 أرقام";
                              //   }
                              //   return null;
                              // },
                            ),

                            20.verticalSpace,

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextFormField(
                                  hintText: "كلمة المرور",
                                  prefix: Icon(
                                    Icons.password,
                                    color: AppColors.mainAppColor,
                                  ),
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
                                    if (confirmPasswordController
                                            .text
                                            .isNotEmpty &&
                                        confirmPasswordController.text !=
                                            value) {
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

                            // CustomTextFormField(
                            //   textInputType: TextInputType.visiblePassword,
                            //
                            //   prefix: Icon(
                            //     Icons.password,
                            //     color: AppColors.mainAppColor,
                            //   ),
                            //   hintText: 'تأكيد كلمة المرور',
                            //   obscureText: cubit.isPasswordConfirm,
                            //   subfix: IconButton(
                            //     onPressed: cubit.changIconPasswordConfirm,
                            //     icon: Icon(
                            //       cubit.subfixConfirm,
                            //       color: AppColors.mainAppColor,
                            //       size: 25.0,
                            //     ),
                            //   ),
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty)
                            //       return 'الرجاء تأكيد كلمة المرور';
                            //     if (value != passwordController.text) {
                            //       return "كلمة المرور غير متطابقة";
                            //     }
                            //     return null;
                            //   },
                            //   controller: confirmPasswordController,
                            // ),
                          ],
                        ),
                      ),

                      20.verticalSpace,

                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (keyForm.currentState!.validate()) {
                                  cubit.registerUser(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: widget.phoneNumber,
                                    activity: selectedActivity ?? '',
                                    gender:genderController.text

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
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [

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
                                            const SizedBox(width: 5),
                                            const Icon(
                                              Icons.arrow_forward,
                                              color: Colors.white,
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

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       'لديك حساب بالفعل؟  ',
                      //       style: TextStyle(
                      //         fontFamily: Fonts.font,
                      //         color: Colors.black,
                      //         fontWeight: FontWeight.w500,
                      //         fontSize: getFontSize(context, 14),
                      //       ),
                      //     ),
                      //     InkWell(
                      //       onTap: () => navigato(context, const LoginScreen()),
                      //       child: Text(
                      //         'تسجيل الدخول',
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
                      // 50.verticalSpace,
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

  Widget _buildSectionHeader(String title, IconData icon) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.mainAppColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          SizedBox(width: 10.w),
          Text(
            title,
            style: TextStyle(
              fontFamily: Fonts.font,
              fontSize: getFontSize(context, 16),
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
