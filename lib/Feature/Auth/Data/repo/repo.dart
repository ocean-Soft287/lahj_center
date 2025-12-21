
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:lahijcenter/core/Failure/failure.dart';

import '../model/register_model.dart';
import '../model/responce_otp_model.dart';
import '../model/user_model.dart';

abstract class Loginrepo {
  Future<Either<Failure, ResponceOtpModel>> verifyOtp({
    required String phoneNumber,
    required String otp,
  });
  Future<Either<Failure ,RegisterResponceModel>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password ,
    required String phone,
    File? image,
    required String activity,
    required String gender,
  });

  Future<Either<Failure, UserModel>> login({
    required String phonenumber,
    //required String password,
  });

  Future<Either<Failure, String>> forgetpassword({
    required String email,
  });

  Future<Either<Failure, String>> resetpassword({
    required String email,
    required String token,
    required String newpassword,
  });

}