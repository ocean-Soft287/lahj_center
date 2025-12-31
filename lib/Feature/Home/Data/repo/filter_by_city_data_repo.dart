import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/Home/Data/model/item_model.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/api_consumer.dart';

class PaginationParams {
  final int page;
  final int perPage;

  PaginationParams({required this.page, required this.perPage});
  Map<String, dynamic> toJson() {
    return {'page': page, 'pageSize': perPage};
  }
}

abstract interface class FilterByCityDataRepo {
  Future<Either<Failure, List<Item>>> getCitiesByGovernorate({
    required int governorateId,
    required PaginationParams params,
  });
}

class FilterByCityDataRepoImpl implements FilterByCityDataRepo {
  final ApiConsumer _apiConsumer;

  FilterByCityDataRepoImpl(this._apiConsumer);

  @override
  Future<Either<Failure, List<Item>>> getCitiesByGovernorate({
    required int governorateId,
    required PaginationParams params,
  }) async {
    try {
      final result = await _apiConsumer.get(
        'http://78.89.159.126:9393/TheOneAPILahj/api/Advertisement/By-AreaIdPaged?areaId=$governorateId',
        queryParameters: params.toJson(),
      );

      // The API returns a paginated response with structure:
      // { "items": [...], "page": 1, "pageSize": 20, "totalItems": X, "totalPages": Y }
      if (result is Map<String, dynamic>) {
        final itemsJson = result['items'] as List;
        final items = itemsJson.map((e) => Item.fromJson(e)).toList();
        return Right(items);
      } else {
        return Left(ServerFailure('Invalid response format'));
      }
    } catch (e) {
      return Left(ServerFailure('Failed to parse items: ${e.toString()}'));
    }
  }
}
