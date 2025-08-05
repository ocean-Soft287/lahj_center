import 'package:dartz/dartz.dart';
import 'package:lahijcenter/Feature/profile/data/models/new_password_model.dart';
import 'package:lahijcenter/Feature/profile/data/repo/new_password_repo.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/dio_consumer.dart';
import 'package:lahijcenter/core/utils/api/endpoint.dart';

class NewPasswordRepoImpl implements NewPasswordRepo{
  final DioConsumer dioConsumer;
  NewPasswordRepoImpl({required this .dioConsumer});
  @override
  Future<Either<Failure, NewPasswordModel>> newpassword({required String oldPassword, required String newPassword}) async{
   try{
     final responce=await dioConsumer.post(EndPoint.Newpassword,
     data: {
       "oldPassword": oldPassword,
       "newPassword": newPassword
     });
     return right(NewPasswordModel.fromJson(responce));

   }catch(e){
     return left(ServerFailure(e.toString()));
   }
  }
}