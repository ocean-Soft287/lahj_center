import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/model/unlike_home.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/repo/unlike_home_repo.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/api_consumer.dart';
import 'package:lahijcenter/core/utils/api/endpoint.dart';

class UnlikeHomeRepoImpl implements UnlikeHomeRepo{
  final ApiConsumer apiConsumer;

  UnlikeHomeRepoImpl({required this.apiConsumer});
  @override
  Future<Either<Failure, UnlikeHome>> unlikeHome(int id) async {
    try {
      final response = await apiConsumer.delete(
        EndPoint.postunlike(id),
      );
      final model = UnlikeHome.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
