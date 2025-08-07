import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lahijcenter/Feature/Auth/Data/repo/repo.dart';
import '../../../../core/Failure/failure.dart';
import '../../../../core/network/local/flutter_secure_storage.dart';
import '../../../../core/utils/api/dio_consumer.dart';
import '../../../../core/utils/api/endpoint.dart';
import '../model/register_model.dart';
import '../model/user_model.dart';

class Loginrepoimp implements Loginrepo {
  final DioConsumer dioConsumer;

  Loginrepoimp({required this.dioConsumer});

  @override
  @override
  @override
  Future<Either<Failure, RegisterResponseModel>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    File? image,
    required String activity,
  }) async {
    try {
      final fcmtoken = "fcm";
      MultipartFile? imageFile;
      if (image != null) {
        imageFile = await MultipartFile.fromFile(image.path);
      }

      final formData = FormData.fromMap({
        "FirstName": firstName,
        "LastName": lastName,
        "Email": email,
        "Password": password,
        "PhoneNumber": phone,
        "Activity": activity,
        "DeviceToken": fcmtoken,
        if (image != null) "Image": imageFile,
      });

      final response = await dioConsumer.post(
        EndPoint.signup,
        data: formData,
        isFromData: true,
      );

      return Right(RegisterResponseModel.fromJson(response));

    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, String>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.otpverifyaccount,
        data: {
          'email': email,
          'otp': otp,
        },
      );

      if (response is String) {
        if (response.trim() == "Email verified. Account activated successfully.") {
          return Right(response);
        } else {
          return Left(ServerFailure("Unexpected response: $response"));
        }
      } else if (response is Map<String, dynamic> && response.containsKey('message')) {
        return Left(ServerFailure("Unexpected message: ${response['message']}"));
      } else {
        return Left(ServerFailure("Unknown response format"));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Dio error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }



  @override
  Future<Either<Failure, String>> forgetpassword({
    required String email,
  }) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.changePass,
        data: {'email': email},
      );

      // طالما السيرفر بيرجع String صريح
      final responseMessage = response.toString();

      if (responseMessage.trim() == "Email is Not Exist") {
        return left(ServerFailure("This email is not registered."));
      }
if(responseMessage.toString()=="Check your inbox you have recieved Reset Link")
  {

    return right(responseMessage);

  }
      return left(ServerFailure(responseMessage));

    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("Forget password failed: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    ///TODO : add fcmtoken
    final fcmtoken = "fcm";

    try {
      final response = await dioConsumer.post(
        EndPoint.login,
        data: {
          'email': email,
          'password': password,
          'rememberMe': true,
          "deviceToken": fcmtoken,
        },

      );

      final json = response as Map<String, dynamic>;
      final model = UserModel.fromJson(json);
      await SecureStorageService.write(SecureStorageService.token, model.token);

      final token= SecureStorageService.read(SecureStorageService.token);
      // final role=SecureStorageService.read(SecureStorageService.role);
      print(token);

      if (model.token.isEmpty) {
        return left(ServerFailure("Missing token in response."));
      }
      return right(model);
    } on DioException catch (e) {

      // print("------------------------------------------------------ VerifyOtpFailure ${e.response?.}");
      if(e.message!.contains("Email is not confirmed.")){
        return left(VerifyOtpFailure(e.response?.statusMessage??""));
      }
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("Login failed: ${e.toString()}"));
    }
  }


  @override
  Future<Either<Failure, String>> resetpassword({
    required String email,
    required String token,
    required String newpassword,
  }) async {
    final data = {'email': email, 'token': token, 'newPassword': newpassword};

    try {
      final response = await dioConsumer.post(
        EndPoint.changePassconfirm,
        data: jsonEncode(data),
      );

      final responseMessage = response.toString();

      if (responseMessage.trim() == "Invalid or Expired Token") {
        return left(ServerFailure("TInvalid or Expired Token."));
      }

      return right(responseMessage);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("Reset password failed: ${e.toString()}"));
    }
  }


  Failure _handleDioError(DioException error) {
    return ServerFailure(error.message ?? "Unknown error occurred");
  }



}