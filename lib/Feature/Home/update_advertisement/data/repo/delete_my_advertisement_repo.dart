import 'package:dartz/dartz.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/api_consumer.dart';
import 'package:lahijcenter/core/utils/api/endpoint.dart';

abstract interface class DeleteMyAdvertisementRepo {
  Future<Either<Failure,String>> deleteMyAdvertisement({required int id,
    required String deletionReason});
}
   
 class DeleteMyAdvertisementRepoImpl implements DeleteMyAdvertisementRepo {
  final ApiConsumer apiConsumer;

  DeleteMyAdvertisementRepoImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, String>> deleteMyAdvertisement({
    required int id,
    required String deletionReason,
  }) async {
    try {
      final response = await apiConsumer.put(
        EndPoint.deletemyadvertisment,
        data: {
          "deletionReason": deletionReason,
          "id": id,
        },
      );

      return Right(response.toString());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
