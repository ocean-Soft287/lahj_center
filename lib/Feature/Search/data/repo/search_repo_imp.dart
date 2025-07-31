import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/Home/Data/model/item_model.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/dio_consumer.dart';
import '../../../../core/network/remote/encrupt.dart';
import '../../../../core/utils/api/endpoint.dart';
import '../../../Home/Data/model/advertismint_response.dart';
import 'search_repo.dart';

class SearchrepoRepoImp implements Searchrepo{
final DioConsumer dioConsumer;
  SearchrepoRepoImp({required this.dioConsumer});
  @override
  @override
  Future<Either<Failure, AdvertisementResponse>> searchbyname(String name,int page) async {
    try {
      final response = await dioConsumer.get(
        EndPoint.search(name,page),
        useCache: true,
        cacheDuration: const Duration(hours: 1),
      );

      if (response != null) {

        final advertisementResponse = AdvertisementResponse.fromJson(response);
print(advertisementResponse);
        return Right(advertisementResponse);

      } else {

        return const Left(ServerFailure('Empty or null response from server'));

      }
    } catch (e) {

      return Left(ServerFailure('Failed to fetch search results: ${e.toString()}'));

    }
  }

}