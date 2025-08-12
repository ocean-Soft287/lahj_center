import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/Home/Data/model/post_model_comment.dart';
import 'package:lahijcenter/Feature/Home/Data/repo/repo_post_comment.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/dio_consumer.dart';
import 'package:lahijcenter/core/utils/api/endpoint.dart';

class PostRepoImplComment implements RepoPostComment {
  final DioConsumer dioConsumer;
  PostRepoImplComment({required this.dioConsumer});

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

      final response = await dioConsumer.post(EndPoint.addcomment, data: data);

      final commentItem = CommentItem.fromJson(response);
      return right(commentItem);
    } catch (e) {
      return left(ServerFailure("Failed to add comment: ${e.toString()}"));
    }
  }
}
