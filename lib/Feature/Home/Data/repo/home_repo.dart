import 'package:dartz/dartz.dart';
import 'package:lahijcenter/core/Failure/failure.dart';

import '../model/advertismint_response.dart';
import '../model/comment_model.dart';
import '../model/item_model.dart';



abstract class Homerepo {
  Future<Either<Failure, List<dynamic>>> fetchCategories() ;
  Future<Either<Failure, AdvertisementResponse>> fetchallitems();
  Future<Either<Failure, AdvertisementResponse>> fetchitemsbygroup({required int number});
  Future<Either<Failure,Item>> fetchitemsbyid({required int number});
 
  

}