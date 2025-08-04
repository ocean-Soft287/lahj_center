import 'package:dartz/dartz.dart';

import 'package:lahijcenter/Feature/profile/data/models/get_profile_model.dart';

import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/dio_consumer.dart';
import 'package:lahijcenter/core/utils/api/endpoint.dart';

import 'get_profile_repo.dart';

class GetProfileRepoImpl implements GetProfileRepo{
   final DioConsumer dioConsumer;
   GetProfileRepoImpl({required this.dioConsumer});

  @override
  Future<Either<Failure, GetProfileModel>> getProfile()async {
    try{
      final responce=await dioConsumer.get(EndPoint.getProfile);
      final model=GetProfileModel.fromJson(responce);
      return Right(model);
    }
    catch(e){
     return Left(ServerFailure(e.toString()));
    }


  }
}