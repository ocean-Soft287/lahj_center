import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lahijcenter/Feature/profile/data/repo/profile_repo.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/dio_consumer.dart';

import '../../../../core/network/local/flutter_secure_storage.dart';
import '../../../../core/network/remote/encrupt.dart';
import '../../../../core/utils/api/endpoint.dart';

class Profilerepoimp implements Profilerepo {
  final DioConsumer dioConsumer;

  Profilerepoimp({required this.dioConsumer});

  @override
  Future<Either<Failure, dynamic>> deleteprofilebyid() async {
      try {
        final userid = await SecureStorageService.read(
          SecureStorageService.customerid,
        );

      final response = await dioConsumer.get(
        "${EndPoint.deleteprofile}$userid",
        useCache: true,
        cacheDuration: const Duration(hours: 1),
      );

      if (response != null && response.toString().isNotEmpty) {
        final decryptedText = decrypt(
          response.toString(),
          privateKey,
          publicKey,
        );
        final dynamic jsonData = jsonDecode(decryptedText);
        return Right(jsonData);
      } else {
        return const Left(ServerFailure('Empty or null response from server'));
      }
    } catch (e) {
      return Left(ServerFailure('Failed to fetch favourites: ${e.toString()}'));
    }
  }

  @override
  @override
  Future<Either<Failure, dynamic>> editimage({
    required File imageFile,
    required int customerId,
    required String arabicName,
    required String englishName,
    required String phone,
    required String password,
    required String email,
  }) async {
    try {

      // 1. Build the payload
      final Map<String, dynamic> payload = {
        "CustomerID": customerId,
        "ArabicName": arabicName,
        "EnglishName": englishName,
        "CustomerPhone": phone,
        "PassWord": password,
        "Email": email,
      };

      // 2. Encrypt the payload
      final encryptedData = encryptData(payload, privateKey, publicKey);

      // 3. Create FormData
      final formData = FormData();
      formData.fields.add(MapEntry("customer", encryptedData));
      // 4. Attach image file
      if (await imageFile.exists()) {
        final fileName = imageFile.path.split('/').last;
        final multipartFile = await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        );
        formData.files.add(MapEntry('images', multipartFile));
      } else {
        return const Left(ServerFailure('❌ Image file not found.'));
      }

      // 5. Send PUT request via DioConsumer
      final response = await dioConsumer.put(
        EndPoint.editprofile,
        isFromData: true,
        data: formData,
      );

      // 6. Decrypt and return response
      if (response != null && response.toString().isNotEmpty) {
        final decryptedText = decrypt(response.toString(), privateKey, publicKey);
        final jsonData = jsonDecode(decryptedText);
        return Right(jsonData);
      } else {
        return const Left(ServerFailure('❌ Empty or null response from server'));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure('Network error: ${e.message}'));
      }
      return Left(ServerFailure('Failed to update profile: ${e.toString()}'));
    }
  }

}
