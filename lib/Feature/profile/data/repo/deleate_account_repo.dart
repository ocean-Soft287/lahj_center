import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/profile/data/models/deleate_account_model.dart';
import 'package:lahijcenter/core/Failure/failure.dart';

abstract class DeleteAccountRepo {
  Future<Either<Failure, DeleateAccountModel>> deleteAccount(
    String userid,
  );
}