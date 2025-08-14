import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/Home/Data/model/get_report_model.dart';
import 'package:lahijcenter/Feature/Home/Data/repo/get_report_repo.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/dio_consumer.dart';
import 'package:lahijcenter/core/utils/api/endpoint.dart';

class GetReportRepoImpl implements GetReportRepo {
  final DioConsumer dioConsumer;
  GetReportRepoImpl({required this.dioConsumer});

  @override
  Future<Either<Failure, GetReportModel>> getReport({
    required int advertCommentId,
    required String reason,
  }) async {
    try {
    

      final response = await dioConsumer.post(
        EndPoint.reportcomment,
        data: {
          "advertCommentId": advertCommentId,
          "reason": reason.toString(),
        },
      );


      if (response != null) {
        final report = GetReportModel.fromJson(response);
        return Right(report);
      } else {
        return Left(ServerFailure("Failed to report comment"));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
