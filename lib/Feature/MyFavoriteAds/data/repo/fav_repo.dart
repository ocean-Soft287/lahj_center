import 'package:dartz/dartz.dart';

import '../../../../../core/Failure/failure.dart';
import '../../../Home/Data/model/advertismint_response.dart';
import '../model/favourite_model.dart';

abstract class Favrepo{
  Future<Either<Failure, AdvertisementResponse>>getfavouritedata();
  Future<Either<Failure, FavouriteResponse>>addofavourite({required int advertisementid});
  Future<Either<Failure, String>>deletefavourite({required int advertisementid});

}