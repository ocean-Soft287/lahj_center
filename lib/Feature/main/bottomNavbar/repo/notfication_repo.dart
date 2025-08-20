import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/main/bottomNavbar/model/notfication_model.dart';
import 'package:lahijcenter/core/Failure/failure.dart';

abstract class NotificationRepo {
  Future<Either<Failure, List<NotificationModel>>> fetchNotifications(

  );
}