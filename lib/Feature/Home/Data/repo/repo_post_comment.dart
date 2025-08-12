import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/Home/Data/model/post_model_comment.dart';
import 'package:lahijcenter/core/Failure/failure.dart';

abstract class RepoPostComment {
  Future<Either<Failure, CommentItem>>addcomment({required int advertisementid,required String comment});
}