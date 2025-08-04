import 'package:dartz/dartz.dart';

import '../../../../core/Failure/failure.dart';
import '../models/get_profile_model.dart';

abstract class GetProfileRepo {
  Future< Either<Failure,GetProfileModel>> getProfile();
}
