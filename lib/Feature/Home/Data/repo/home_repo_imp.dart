import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lahijcenter/Feature/Home/Data/model/item_model.dart';
import '../../../../core/Failure/failure.dart';
import '../../../../core/utils/api/dio_consumer.dart';
import '../../../../core/utils/api/endpoint.dart';
import '../model/advertismint_response.dart';
import '../model/comment_model.dart';
import 'home_repo.dart';

class Homerepoimp implements Homerepo {
  final DioConsumer dioConsumer;
  Homerepoimp({required this.dioConsumer});

  @override
  Future<Either<Failure, List<dynamic>>> fetchCategories() async {
    try {
      final response = await dioConsumer.get(
        EndPoint.categories,
        useCache: true,
        cacheDuration: const Duration(hours: 1),
      );

      if (response != null) {
        return Right(response); // مباشرة من غير تعريف جديد
      } else {
        return const Left(ServerFailure('Empty or null response from server'));
      }
    } catch (e) {
      return Left(ServerFailure('Failed to fetch categories: ${e.toString()}'));
    }
  }


  @override
  Future<Either<Failure, AdvertisementResponse>> fetchallitems() async {
    try {
      final response = await dioConsumer.get(
        EndPoint.addvertisminteall,
        useCache: true,
      );

      if (response != null) {
        // Convert the response to AdvertisementResponse
        final advertisementResponse = AdvertisementResponse.fromJson(response);
        return Right(advertisementResponse);
      } else {
        return const Left(ServerFailure('Empty or null response from server'));
      }
    } catch (e) {
      return Left(ServerFailure('Failed to fetch items: ${e.toString()}'));
    }
  }
  @override
  Future<Either<Failure, AdvertisementResponse>> fetchitemsbygroup({
    required int number,
  }) async {
    try {


      final response = await dioConsumer.get(
        EndPoint.getAdvertisementsByGroupID(number),
        useCache: true,
        cacheDuration: const Duration(hours: 1),
      );

      if (response != null) {
        // Convert the response to AdvertisementResponse
        final advertisementResponse = AdvertisementResponse.fromJson(response);
        return Right(advertisementResponse);
      } else {
        return const Left(ServerFailure('Empty or null response from server'));
      }
    } catch (e) {
      return Left(ServerFailure('Failed to fetch items: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Item>> fetchitemsbyid({
    required int number,
  }) async {
    try {
      final response = await dioConsumer.get(
        EndPoint.getitembyid(number),
        useCache: true,
        cacheDuration: const Duration(hours: 1),
      );

      if (response.toString().isNotEmpty) {

final item=Item.fromJson(response);
        return Right(item);
      } else {
        return const Left(ServerFailure('Empty or null response from server'));
      }
    } catch (e) {
      return Left(ServerFailure('Failed to fetch categories: ${e.toString()}'));
    }
  }

 
  @override
  Future<Either<Failure, CommentModel>> fetchcoomentbyid({
    required int pagesize,
    required int number,
    required int page,
  }) async {
    try {
      final response = await dioConsumer.get(
        EndPoint.getComments(number, page, pagesize),
        useCache: true,
        cacheDuration: const Duration(hours: 1),
      );

      if (response.toString().isNotEmpty) {
        final res = CommentModel.fromJson(response);
        return Right(res);
      } else {
        return const Left(ServerFailure('Empty or null response from server'));
      }
    } catch (e) {
      return Left(ServerFailure('Failed to fetch comments: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, CommentItem>> addcomment({
    required int advertisementid,
    required String comment,
  }) async {
    try {
      final Map<String, dynamic> data = {
        "advertisementId": advertisementid,
        "comment": comment,
      };

      final response = await dioConsumer.post(
        EndPoint.addcomment,
        data: data,
      );

      final commentItem = CommentItem.fromJson(response);
      return right(commentItem);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("Failed to add comment: ${e.toString()}"));
    }
  }


  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ServerFailure('Connection timeout');
      case DioExceptionType.badResponse:
        return ServerFailure('Server error: ${error.response?.statusCode}');
      case DioExceptionType.cancel:
        return const ServerFailure('Request to API server was cancelled');
      case DioExceptionType.connectionError:
        return const ServerFailure('Connection error');
      case DioExceptionType.unknown:
      default:
        return const ServerFailure('Unexpected error occurred');
    }
  }
}
