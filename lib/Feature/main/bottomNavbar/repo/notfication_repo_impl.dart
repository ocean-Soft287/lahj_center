import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/main/bottomNavbar/model/notfication_model.dart';
import 'package:lahijcenter/Feature/main/bottomNavbar/repo/notfication_repo.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/api_consumer.dart';
import 'package:lahijcenter/core/utils/api/endpoint.dart';

class NotficationRepoImpl implements NotificationRepo {
  final ApiConsumer apiConsumer;
  NotficationRepoImpl({required this.apiConsumer});
  
  @override
  Future<Either<Failure, List<NotificationModel>>> fetchNotifications() async {
    try {
      final response = await apiConsumer.get(
        EndPoint.getNotifications,
      );

      if (response is List) {
        final notifications = response
            .map((item) => NotificationModel.fromJson(item))
            .toList()
            .cast<NotificationModel>();

        return Right(notifications);
      } else {
        return Left(ServerFailure("Unexpected response format: $response"));
      }
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
