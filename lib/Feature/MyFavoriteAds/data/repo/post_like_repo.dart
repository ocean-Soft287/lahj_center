import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/MyFavoriteAds/data/model/post_like_model.dart';
import 'package:lahijcenter/core/Failure/failure.dart';

abstract class PostLikeRepo {


  Future<Either<Failure,void>>postlike(
    int id
  );
  

  }
