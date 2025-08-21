import 'package:dartz/dartz.dart';
import 'package:lahijcenter/core/Failure/failure.dart';

import '../../../Home/Data/model/advertismint_response.dart';

abstract class Searchrepo{
  Future<Either<Failure, AdvertisementResponse>> searchbyname(String name, int page);









}