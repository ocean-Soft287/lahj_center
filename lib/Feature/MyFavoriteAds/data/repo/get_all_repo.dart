import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/model/get_all_favourite_model.dart';
import 'package:lahijcenter/core/Failure/failure.dart';

abstract class GetAllFavouriteRepo {
  Future<Either<Failure,GetAllFavourite >>getfavouritedata(
    int page,
  int pageSize,


  );
}