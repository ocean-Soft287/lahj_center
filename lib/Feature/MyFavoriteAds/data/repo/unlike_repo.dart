import 'package:dartz/dartz.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import '../model/unlike_model.dart';

abstract class UnlikeRepo {
  Future<Either<Failure, UnlikeModel>> unlikeAd(int adId);
}
