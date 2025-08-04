import 'dart:convert';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:lahijcenter/Feature/profile/data/models/update_profile_model.dart';
import 'package:lahijcenter/Feature/profile/data/repo/update_profile_repo.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:lahijcenter/core/utils/api/dio_consumer.dart';
import '../../../../core/utils/api/endpoint.dart';

class UpadateProfileRepoImpl implements UpdateProfileRepo {
  final DioConsumer dioConsumer;

  UpadateProfileRepoImpl({required this.dioConsumer});

  @override
  Future<Either<Failure, UpdateProfileModel>> updateprofile({
    required String name,
    required String email,
    required String phone,
    String? imageBase64,
  }) async {
    try {
      final formData = FormData();


      formData.fields.addAll([
        MapEntry('FirstName', name),
        MapEntry('LastName', name),
        MapEntry('Email', email),
        MapEntry('PhoneNumber', phone),
        MapEntry('Activity', 'string'),
      ]);

      if (imageBase64 != null && imageBase64.isNotEmpty) {
        Uint8List bytes = base64Decode(imageBase64);

        formData.files.add(
          MapEntry(
            'Image',
            MultipartFile.fromBytes(
              bytes,
              filename: 'profile_image.jpg',
              contentType: MediaType('image', 'jpeg'),
            ),
          ),
        );
      }

      // تنفيذ الطلب
      final response = await dioConsumer.put(
        EndPoint.Updateprofile,
        data: formData,
        isFromData: true, // تأكد أن dioConsumer يتعامل معها كـ multipart
      );

      return Right(UpdateProfileModel.fromJson(response));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
