import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/Home/Data/model/get_report_model.dart';
import 'package:lahijcenter/core/Failure/failure.dart';

abstract class GetReportRepo {
  Future<Either<Failure, GetReportModel>> getReport({
    required int advertCommentId,
    required String reason,
  });
}
