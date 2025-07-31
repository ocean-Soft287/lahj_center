

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/Home/Data/model/advertismint_response.dart';

import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/dio_consumer.dart';

import '../../../../core/network/local/flutter_secure_storage.dart';
import '../../../../core/network/remote/encrupt.dart';
import '../../../../core/utils/api/endpoint.dart';
import '../../../Home/Data/model/item_model.dart';
import 'myad_repo.dart';

class Myaddimp implements Myaddrepo{
final DioConsumer dioConsumer;

  Myaddimp({required this.dioConsumer});
  @override
  Future<Either<Failure,AdvertisementResponse>> getmyad() async {
    try {
      final response = await dioConsumer.get(
        EndPoint.myadds,
        useCache: true,
        cacheDuration: const Duration(hours: 1),
      );

      if (response != null && response.toString().isNotEmpty) {
final advertisminte=AdvertisementResponse.fromJson(response);

        return Right(advertisminte);
      } else {
        return const Left(ServerFailure('Empty or null response from server'));
      }
    } catch (e) {
      return Left(ServerFailure('Failed to fetch ads: ${e.toString()}'));
    }
  }



  @override
  Future<Either<Failure,String>> deletemyadd(int id,String reason) async{
    try {
      Map<String, dynamic>addandreason={

        "id": id,
        "deletionReason": reason

      };
      final response = await dioConsumer.put(
        EndPoint.deletemyadd,
data: addandreason
      );

      if (response != null && response.toString()=="Advertisement Deleted Successfully") {

        return Right(response);
      } else {
        return const Left(ServerFailure('Empty or null response from server'));
      }
    } catch (e) {
      return Left(ServerFailure('Failed to fetch favourites: ${e.toString()}'));
    }
  }


}