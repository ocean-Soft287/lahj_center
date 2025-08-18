import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/model/unlike_home.dart';
import 'package:lahijcenter/core/Failure/failure.dart';

abstract class UnlikeHomeRepo {
  Future<Either<Failure,UnlikeHome>>unlikeHome(
    int id
  );

}