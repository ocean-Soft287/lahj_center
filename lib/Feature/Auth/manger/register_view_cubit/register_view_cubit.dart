import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:lahijcenter/Feature/Auth/manger/register_view_cubit/register_view_state.dart';
import '../../../../core/network/local/flutter_secure_storage.dart';
import '../../Data/repo/repo.dart';

class RegisterViewCubit extends Cubit<RegisterViewState> {
  final Loginrepo loginrepo;

  RegisterViewCubit(this.loginrepo) : super(InitializeRegisterViewState());

  bool isPassword = true;
  bool isPasswordConfirm = true;
  IconData subfix = Icons.visibility_off;
  IconData subfixConfirm = Icons.visibility_off;

  void changIconPassword() {
    isPassword = !isPassword;
    subfix = isPassword ? Icons.visibility_off : Icons.visibility;
    emit(ChangeIconPasswordSuccess());
  }

  void changIconPasswordConfirm() {
    isPasswordConfirm = !isPasswordConfirm;
    subfixConfirm = isPasswordConfirm ? Icons.visibility_off : Icons.visibility;
    emit(ChangeIconPasswordSuccess());
  }

  Future<void> verifotp({
    required String phoneNumber,
    required String otp,
  }) async {
    emit(otpLoading());

    final result = await loginrepo.verifyOtp(phoneNumber: phoneNumber, otp: otp

    );

    result.fold(
          (failure) {
        debugPrint("❌ Registration Error: ${failure.message}");
        emit(otpError(failure.message));
      },
          (data) {
        debugPrint("✅ OTP Success: ${jsonEncode(data)}");

        if (data.member?.token != null && data.member!.token.isNotEmpty) {
          emit(otpSuccessGoHome());
        } else if (data.canRegister) {
          emit(otpSuccessGoRegister());
        } else {
          emit(otpError("Unexpected OTP response"));
        }
      },
    );
  }

  Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String gender,
    File? image,
    required String activity,
  }) async {
    emit(RegisterViewStateLoading());

    final result = await loginrepo.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phone: phone,
      image: image,
      activity: activity,
      gender: gender,
    );

    result.fold(
          (failure) {
        debugPrint("❌ Registration Error: ${failure.message}");
        emit(RegisterViewStateError(failure.message ?? 'حدث خطأ'));
      },
          (data) async {
        debugPrint("✅ Registration Successful: ${jsonEncode(data)}");


        if (data.token != null && data.token!.isNotEmpty) {
          await SecureStorageService.write(
            SecureStorageService.token,
            data.token!,
          );
          await SecureStorageService.write(SecureStorageService.name, "${data.firstName} ${data.lastName}");
          await SecureStorageService.write(SecureStorageService.email, data.email);
          await SecureStorageService.write(SecureStorageService.customerid, data.id);
print("-----------data saved in secure storage");
print("------data ${data.id}     ${SecureStorageService.read(SecureStorageService.customerid)}");
        }

        emit(RegisterViewStateSuccess());
      },
    );
  }
}
