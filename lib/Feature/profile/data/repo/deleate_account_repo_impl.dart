import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/profile/data/models/deleate_account_model.dart';
import 'package:lahijcenter/Feature/profile/data/repo/deleate_account_repo.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/api_consumer.dart';
import 'package:lahijcenter/core/utils/api/endpoint.dart';

class DeleateAccountRepoImpl implements DeleteAccountRepo {
  final ApiConsumer apiConsumer;

  DeleateAccountRepoImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, DeleateAccountModel>> deleteAccount(
    String userid,
  ) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.deleateAccount(userid),

        withAuth: true,
      );

      print("Delete account API response: $response");

      final model = DeleateAccountModel.fromResponse(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
