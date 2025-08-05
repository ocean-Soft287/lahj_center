import 'package:dartz/dartz.dart';
import 'package:lahijcenter/core/Failure/failure.dart';

import '../models/new_password_model.dart';

abstract class NewPasswordRepo{
  Future<Either<Failure,NewPasswordModel>>newpassword({
    required String oldPassword,
    required String newPassword,
  } );
}