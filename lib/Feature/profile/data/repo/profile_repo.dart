import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:lahijcenter/core/Failure/failure.dart';

abstract class Profilerepo {
  Future<Either<Failure, dynamic>> deleteprofilebyid();
  Future<Either<Failure, dynamic>> editimage({    required File imageFile,
    required int customerId,
    required String arabicName,
    required String englishName,
    required String phone,
    required String password,
    required String email,});
}
