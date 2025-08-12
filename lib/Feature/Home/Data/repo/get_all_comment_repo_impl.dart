import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/Home/Data/model/comment_model.dart';
import 'package:lahijcenter/Feature/Home/Data/repo/get_all_comment_repo.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/dio_consumer.dart';
import 'package:lahijcenter/core/utils/api/endpoint.dart';

class GetAllCommentRepoImpl implements GetAllCommentRepo {
  final DioConsumer dioConsumer;
  GetAllCommentRepoImpl({required this.dioConsumer});

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
}
