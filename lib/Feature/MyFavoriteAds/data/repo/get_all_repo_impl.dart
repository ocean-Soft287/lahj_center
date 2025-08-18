import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/model/get_all_favourite_model.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/repo/get_all_repo.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/api_consumer.dart';
import 'package:lahijcenter/core/utils/api/endpoint.dart';

class GetAllFavouriteRepoImpl implements GetAllFavouriteRepo {
  final ApiConsumer apiConsumer;

  GetAllFavouriteRepoImpl(this.apiConsumer);

  @override
  Future<Either<Failure, GetAllFavourite>> getfavouritedata(
      int page, int pageSize) async {
    try {
      final response = await apiConsumer.get(
        EndPoint.getallFavourite,
        queryParameters: {
          "page": page.toString(),
          "pageSize": pageSize.toString(),
        },
      );

      final model = GetAllFavourite.fromJson(response);

      return Right(model);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
