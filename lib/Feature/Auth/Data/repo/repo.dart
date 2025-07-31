
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:lahijcenter/core/Failure/failure.dart';

import '../model/register_model.dart';
import '../model/user_model.dart';

abstract class Loginrepo {
  Future<Either<Failure, String>> verifyOtp({
    required String email,
    required String otp,
  });
  Future<Either<Failure ,RegisterResponseModel>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password ,
    required String phone,
    File? image,
    required String activity,
  });

  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
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