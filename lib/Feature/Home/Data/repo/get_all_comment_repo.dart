import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/Home/Data/model/comment_model.dart';
import 'package:lahijcenter/core/Failure/failure.dart';

abstract class GetAllCommentRepo {
   Future<Either<Failure, CommentModel>> fetchcoomentbyid({
 required int pagesize,
  required int number,
  required int page,
});
}