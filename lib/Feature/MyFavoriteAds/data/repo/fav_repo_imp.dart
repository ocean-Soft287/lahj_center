

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/model/favourite_model.dart';

import '../../../../core/Failure/failure.dart';
import '../../../../core/network/local/flutter_secure_storage.dart';
import '../../../../core/network/remote/encrupt.dart';
import '../../../../core/utils/api/dio_consumer.dart';
import '../../../../core/utils/api/endpoint.dart';
import '../../../Home/Data/model/advertismint_response.dart';
import 'fav_repo.dart';

class FavRepoImp implements Favrepo {
  final DioConsumer dioConsumer;

  FavRepoImp({required this.dioConsumer});

  @override
  Future<Either<Failure, AdvertisementResponse>> getfavouritedata() async {


      try {

        final response = await dioConsumer.get(
          EndPoint.favourite,
          useCache: true,
          cacheDuration: const Duration(hours: 1),
        );

        if (response != null && response.toString().isNotEmpty) {
      final favresp=AdvertisementResponse.fromJson(response);
          return Right(favresp);
        } else {
          return const Left(ServerFailure('Empty or null response from server'));
        }
      } catch (e) {
        return Left(ServerFailure('Failed to fetch categories: ${e.toString()}'));
      }
  }

  @override
  Future<Either<Failure, FavouriteResponse>> addofavourite({required int advertisementid}) async{
    try {

      final Map<String, dynamic> payload = {
        "Id": advertisementid,
      };


      final response = await dioConsumer.post(
        EndPoint.createfavourite(advertisementid),
        data: payload,
      );

final favres=FavouriteResponse.fromJson(response);
      return Right(favres);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure("Failed to update favourite: ${e.toString()}"));
    }
  }

  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ServerFailure('Connection timeout');
      case DioExceptionType.badResponse:
        return ServerFailure('Server error: ${error.response?.statusCode}');
      case DioExceptionType.cancel:
        return const ServerFailure('Request to API server was cancelled');
      case DioExceptionType.connectionError:
        return const ServerFailure('Connection error');
      case DioExceptionType.unknown:
      default:
        return const ServerFailure('Unexpected error occurred');
    }
  }

  @override
  Future<Either<Failure, String>> deletefavourite({required int advertisementid}) async{
    try {

      final response = await dioConsumer.delete(
        EndPoint.deletefavourite((advertisementid)),
      );
if(response.toString()=="UnLike Successfully"){
  return Right(response);
}
return left(ServerFailure("error"));
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure("Failed to update favourite: ${e.toString()}"));
    }
  }


}
