import 'package:dartz/dartz.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/api_consumer.dart';
import 'package:lahijcenter/core/utils/api/endpoint.dart';

import '../models/advertisement_responce.dart';
import '../models/update_advertisement_model.dart';

abstract class AdvertisementRepo {
  Future<Either<Failure, AdvertisementResponseModel>> updateAdvertisement(
    UpdateAdvertisementModel model,
  );
}

class AdvertisementRepoImpl implements AdvertisementRepo {
  final ApiConsumer apiConsumer;

  AdvertisementRepoImpl(this.apiConsumer);

  @override
  Future<Either<Failure, AdvertisementResponseModel>> updateAdvertisement(
    UpdateAdvertisementModel model,
  ) async {
    try {
      final response = await apiConsumer.put(
        EndPoint.updateAdvertisement,
        isFromData: true,
        data: model.toJson(),
      );

      final ad = AdvertisementResponseModel.fromJson(response);

      return Right(ad);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
