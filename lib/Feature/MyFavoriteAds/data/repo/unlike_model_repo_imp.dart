


import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/model/unlike_model.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/repo/unlike_repo.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/api_consumer.dart';
import 'package:lahijcenter/core/utils/api/endpoint.dart';

class UnlikeRepoImpl implements UnlikeRepo {
  final ApiConsumer apiConsumer;

  UnlikeRepoImpl({required this.apiConsumer});

 

  @override
  Future<Either<Failure, UnlikeModel>> unlikeAd(int adId) async{
  try{
    final responce=await apiConsumer.delete(
       EndPoint.unlikefavourite.replaceFirst('{Id}', id.toString()));
       final model=UnlikeModel.fromJson(responce);
       return Right(model);
  }catch(error){
    return Left(ServerFailure(error.toString()));




  }
  }
}
