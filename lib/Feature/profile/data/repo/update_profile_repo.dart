import 'package:dartz/dartz.dart';

import '../../../../core/Failure/failure.dart';
import '../models/update_profile_model.dart';

abstract class UpdateProfileRepo {
  Future<Either<Failure, UpdateProfileModel>> updateprofile({
    required String name,
    required String email,
    required String phone,
    String? imageBase64,
});


}