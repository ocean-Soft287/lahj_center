import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/Failure/failure.dart';
import '../../../Home/Data/model/currency_model.dart';
import '../model/currency.dart';
import '../model/government_model.dart';
import '../model/group.dart';
import '../model/services.dart';

abstract class Addadvertisminterepo {
  Future<Either<Failure, List<ModelCurrency>>> getcurrency();
  Future<Either<Failure, List<Government>>> getGovernment();
  Future<Either<Failure, List<Group>>> getgroup();
  Future<Either<Failure, List<Services>>> getServices();

  Future<Either<Failure, String>> addAdvertisminte({
    required String name,
    required String phone,
    required int groupId,
    required int serviceId,
    required double price,
    required bool isCloseReplies,
    required int currencyId,
    required int governorateId,
    required String area,
    required String description,
    required List<File> images,
  });


  Future<Either<Failure, String>> edit({
    required int id,
    required String name,
    required String phone,
    required int groupId,
    required String groupName,
    required String groupEName,
    required int serviceId,
    required String serviceName,
    required String serviceEName,
    required double price,
    required int currencyId,
    required String currencyName,
    required String currencyEName,
    required int regionId,
    required String regionName,
    required String regionEName,
    required String area,
    required String description,
    required int customerId,
    required String customerName,
    required String customerEName,
    required String date,
    required bool isCloseReplies,
    required int stateId,
    required String stateName,
    required String stateEName,
    required List<File> images,
    required List<String> oldImage,
    String? deletionReason,
  });

}
