import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lahijcenter/Feature/profile/manager/new_password_cubit.dart';
import 'package:lahijcenter/Feature/profile/manager/new_password_state.dart';
import 'package:lahijcenter/Feature/profile/screen/password_changed_success.dart';

class PasswordUpdateScreen extends StatefulWidget {
  const PasswordUpdateScreen({Key? key}) : super(key: key);

  @override
  State<PasswordUpdateScreen> createState() => _PasswordUpdateScreenState();
}

class _PasswordUpdateScreenState extends State<PasswordUpdateScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isOldPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final isDesktop = screenWidth > 1200;

    // Responsive padding and sizing
    final horizontalPadding = isDesktop ? 40.0 : (isTablet ? 30.0 : 20.0);
    final maxWidth = isDesktop ? 500.0 : (isTablet ? 400.0 : double.infinity);
    final avatarSize = isTablet ? 120.0 : 100.0;
    final titleFontSize = isTablet ? 26.0 : 22.0;
    final inputSpacing = isTablet ? 20.0 : 16.0;
    final fontSize = isTablet ? 16.0 : 14.0;
    final fieldHeight = isTablet ? 60.0 : 55.0;
    final dotSize = isTablet ? 12.0 : 10.0;

    return  BlocProvider(
      create: (_) => GetIt.instance<NewPasswordCubit>(),
      child: BlocConsumer<NewPasswordCubit,NewpasswordState>(
        listener: (context,state){
          if (state is NewpasswordLoading){
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(color: Color(0xFF4CAF50)),
              ),
            );
          }else if (state is NewpasswordSuccess){
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم تحديث كلمة المرور بنجاح'),
                backgroundColor: Color(0xFF4CAF50),
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PasswordChangedSuccess()));

          }else if (state is NewpasswordError){
            Navigator.of(context).pop(); // Close dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context,state){
          final cubit=context.read<NewPasswordCubit>();

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: isTablet ? 28 : 24,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SafeArea(
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 20,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar and dots section
                        SizedBox(height: screenHeight * 0.02),

                        // Avatar with question mark
                        Container(
                          width: avatarSize,
                          height: avatarSize,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF4A5568),
                          ),
                          child: Stack(
                            children: [
                              // Face
                              Positioned(
                                bottom: 20,
                                left: 20,
                                right: 20,
                                child: Container(
                                  height: avatarSize * 0.6,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFED8077),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ),
                                  ),
                                ),
                              ),
                              // Question mark
                              Positioned(
                                top: 15,
                                left: 15,
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '?',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.03),

                        // Green dots indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: dotSize,
                              height: dotSize,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF4CAF50),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: dotSize,
                              height: dotSize,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF4CAF50),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: dotSize,
                              height: dotSize,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF4CAF50),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: dotSize,
                              height: dotSize,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF4CAF50),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.05),

                        // Title
                        Text(
                          'تحديث كلمة المرور',
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: screenHeight * 0.04),

                        // Old Password Field
                        Container(
                          height: fieldHeight,
                          child: TextFormField(
                            controller: oldPasswordController,
                            obscureText: !isOldPasswordVisible,
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: fontSize),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال كلمة المرور القديمة';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'كلمة المرور القديمة',
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                                fontSize: fontSize,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isOldPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey[600],
                                  size: isTablet ? 24 : 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isOldPasswordVisible = !isOldPasswordVisible;
                                  });
                                },
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.grey[600],
                                size: isTablet ? 24 : 20,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: isTablet ? 20 : 16,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: inputSpacing),

                        // New Password Field
                        Container(
                          height: fieldHeight,
                          child: TextFormField(
                            controller: newPasswordController,
                            obscureText: !isNewPasswordVisible,
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: fontSize),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال كلمة المرور الجديدة';
                              }
                              if (value.length < 6) {
                                return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'كلمة المرور الجديدة',
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                                fontSize: fontSize,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey[600],
                                  size: isTablet ? 24 : 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isNewPasswordVisible = !isNewPasswordVisible;
                                  });
                                },
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.grey[600],
                                size: isTablet ? 24 : 20,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: isTablet ? 20 : 16,
                              ),
                            ),
                          ),
                        ),

                        // Helper text for new password
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'يجب أن تحتوي كلمة المرور على أحرف وأرقام',
                              style: TextStyle(
                                fontSize: isTablet ? 14 : 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: inputSpacing),

                        // Confirm Password Field
                        Container(
                          height: fieldHeight,
                          child: TextFormField(
                            controller: confirmPasswordController,
                            obscureText: !isConfirmPasswordVisible,
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: fontSize),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى تأكيد كلمة المرور الجديدة';
                              }
                              if (value != newPasswordController.text) {
                                return 'كلمة المرور غير متطابقة';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'تأكيد كلمة المرور الجديدة',
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                                fontSize: fontSize,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey[600],
                                  size: isTablet ? 24 : 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isConfirmPasswordVisible = !isConfirmPasswordVisible;
                                  });
                                },
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.grey[600],
                                size: isTablet ? 24 : 20,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: isTablet ? 20 : 16,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.05),

                        // Update Button
                        Container(
                          width: double.infinity,
                          height: isTablet ? 60 : 55,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.changePassword(oldPassword: oldPasswordController.text.trim(), newPassword: newPasswordController.text.trim());


                                // Simulate API call

                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4CAF50),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              textStyle: TextStyle(
                                fontSize: isTablet ? 18 : 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            child: const Text('تحديث'),
                          ),
                        ),

                        // Extra spacing for better UX on smaller screens
                        SizedBox(height: screenHeight * 0.05),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );}
      ),
    );
  }
}