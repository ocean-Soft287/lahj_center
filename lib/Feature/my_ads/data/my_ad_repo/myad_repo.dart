import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/Home/Data/model/item_model.dart';

import '../../../../core/Failure/failure.dart';
import '../../../Home/Data/model/advertismint_response.dart';

abstract class Myaddrepo{
  Future<Either<Failure, AdvertisementResponse>>getmyad();
  Future<Either<Failure, String>> deletemyadd(int id,String reason);

}