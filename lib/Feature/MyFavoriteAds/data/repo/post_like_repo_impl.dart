import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/model/post_like_model.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/repo/post_like_repo.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/api_consumer.dart';
import 'package:lahijcenter/core/utils/api/endpoint.dart';

class PostLikeRepoImpl implements PostLikeRepo{
  final ApiConsumer apiConsumer;

  PostLikeRepoImpl({required this.apiConsumer});
  
  @override
  Future<Either<Failure, PostLikeModel>> postlike(int id)async {
  try{
    final responce=await apiConsumer.post(
      EndPoint.postfavourite(id),
    );
      final model=PostLikeModel.fromJson(responce);
      return Right(
        model,
      );
  }catch(e){
    return Left(ServerFailure(e.toString()));




  
    

  }
  }
}