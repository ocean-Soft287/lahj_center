import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:lahijcenter/Feature/AddAdvertisement/data/repo/repo.dart';
import 'package:lahijcenter/core/Failure/failure.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/network/remote/encrupt.dart';
import '../../../../core/utils/api/endpoint.dart';
import '../../../../../core/utils/api/dio_consumer.dart';
import '../../../Home/Data/model/currency_model.dart';
import '../model/government_model.dart';
import '../model/group.dart';
import '../model/services.dart';

class Addadvertisminterepoimp implements Addadvertisminterepo {
  final DioConsumer dioConsumer;

  // Use an in-memory cache (just a variable for now, or you could use something like SharedPreferences for persistence)
  List<dynamic> cachedCurrencyData = [];
  List<dynamic> cachedGovernmentData = [];

  Addadvertisminterepoimp({required this.dioConsumer});

  @override
  Future<Either<Failure, List<Currency>>> getcurrency() async {
    try {
      final response = await dioConsumer.get(EndPoint.getcurrency);
      final List<Currency> currencies = (response as List)
          .map((e) => Currency.fromJson(e))
          .toList();
      return Right(currencies);

    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Government>>> getGovernment() async {
    try {
      final response = await dioConsumer.get(EndPoint.getAllGovernorates);

      if (response is List) {
        final List<Government> governments = response
            .map((e) => Government.fromJson(e as Map<String, dynamic>))
            .toList();
        return Right(governments);
      } else {
        return Left(ServerFailure('فشل في جلب المحافظات: البيانات غير متوقعة'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  Future<Either<Failure, List<Group>>> getgroup() async {
    try {
      final response = await dioConsumer.get(EndPoint.getallGroups);
      final List<Group> groups = (response as List)
          .map((e) => Group.fromJson(e))
          .toList();
      return Right(groups);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Services>>> getServices() async {
    try {
      final response = await dioConsumer.get(EndPoint.getallServices);
      final List<Services> services = (response as List)
          .map((e) => Services.fromJson(e))
          .toList();
      return Right(services);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, String>> addaddvertisminte({
    required int id,
    required String name,
    required String phone,
    required int groupId,
    required String groupName,
    required String groupEName,
    required int serviceId,
    required String serviceName,
    required String serviceEName,
    required double price,
    required int currencyId,
    required String currencyName,
    required String currencyEName,
    required int regionId,
    required String regionName,
    required String regionEName,
    required String area,
    required String description,
    required int customerId,
    required String customerName,
    required String customerEName,
    required String date,
    required bool isCloseReplies,
    required int stateId,
    required String stateName,
    required String stateEName,
    required List<File> images,
    String? deletionReason,
  }) async {
    try {

      final Map<String, dynamic> payload = {
        "Id": id,
        "Name": name,
        "Phone": phone,
        "GroupId": groupId,
        "GroupName": groupName,
        "GroupEName": groupEName,
        "ServiceId": serviceId,
        "ServiceName": serviceName,
        "ServiceEName": serviceEName,
        "Price": price,
        "CurrencyId": currencyId,
        "CurrencyName": currencyName,
        "CurrencyEName": currencyEName,
        "RegionId": regionId,
        "RegionName": regionName,
        "RegionEName": regionEName,
        "Area": area,
        "Discription": description,
        "CustomerId": customerId,
        "CustomerName": customerName,
        "CustomerEName": customerEName,
        "Date": date,
        "IsCloseReplies": isCloseReplies,
        "StateId": stateId,
        "StateName": stateName,
        "StateEName": stateEName,
        "DeletionReason": deletionReason,
      };

      final encryptedDatapayload = encryptData(payload, privateKey, publicKey);

      final formData = FormData();
      formData.fields.add(MapEntry("advertisement", encryptedDatapayload));

      for (var i = 0; i < images.length; i++) {
        final image = images[i];

        if (!await image.exists()) {
          continue;
        }

        final fileName = image.path.split('/').last;

        final multipartFile = await MultipartFile.fromFile(
          image.path,
          filename: fileName,
        );

        formData.files.add(MapEntry('images', multipartFile));
      }

      final response = await dioConsumer.post(
        EndPoint.addads,
        isFromData: true,
        data: formData,
      );

      if (response != null && response.toString().isNotEmpty) {
        try {
          final decryptedText = decrypt(
            response.toString(),
            privateKey,
            publicKey,
          );
          final String jsonData = jsonDecode(decryptedText);
          return Right(jsonData);
        } catch (e) {
          return Left(
            ServerFailure(
              '❌ Failed to process server response: ${e.toString()}',
            ),
          );
        }
      } else {
        return const Left(
          ServerFailure('❌ Empty or null response from server'),
        );
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure('Network error: ${e.message}'));
      }
      return Left(
        ServerFailure('Failed to send advertisement: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, String>> edit({
    required int id,
    required String name,
    required String phone,
    required int groupId,
    required String groupName,
    required String groupEName,
    required int serviceId,
    required String serviceName,
    required String serviceEName,
    required double price,
    required int currencyId,
    required String currencyName,
    required String currencyEName,
    required int regionId,
    required String regionName,
    required String regionEName,
    required String area,
    required String description,
    required int customerId,
    required String customerName,
    required String customerEName,
    required String date,
    required bool isCloseReplies,
    required int stateId,
    required String stateName,
    required String stateEName,
    required List<File> images,
    required List<String> oldImage,
    String? deletionReason,
  }) async {
    try {
      final Map<String, dynamic> payload = {
        "Id": id,
        "Name": name,
        "Phone": phone,
        "GroupId": groupId,
        "GroupName": groupName,
        "GroupEName": groupEName,
        "ServiceId": serviceId,
        "ServiceName": serviceName,
        "ServiceEName": serviceEName,
        "Price": price,
        "CurrencyId": currencyId,
        "CurrencyName": currencyName,
        "CurrencyEName": currencyEName,
        "RegionId": regionId,
        "RegionName": regionName,
        "RegionEName": regionEName,
        "Area": area,
        "Discription": description,
        "CustomerId": customerId,
        "CustomerName": customerName,
        "CustomerEName": customerEName,
        "Date": date,
        "IsCloseReplies": isCloseReplies,
        "StateId": stateId,
        "StateName": stateName,
        "StateEName": stateEName,
        "DeletionReason": deletionReason,
      };
print(payload);
      final encryptedDatapayload = encryptData(payload, privateKey, publicKey);
      print(encryptedDatapayload);

      final formData = FormData();
      formData.fields.add(MapEntry("advertisement", encryptedDatapayload));

      final allImages = [...images]; // ✅ صور جديدة فقط

      // ✅ حمل الصور القديمة من السيرفر اللي لسه موجودة بس
      for (var name in oldImage) {
        final url = 'http://78.89.159.126:9393/TheOneLahjAPI/AdvertImages/$name';
        try {
          final response = await http.get(Uri.parse(url));
          if (response.statusCode == 200) {
            final tempDir = await getTemporaryDirectory();
            final filePath = '${tempDir.path}/$name';
            final file = File(filePath);
            await file.writeAsBytes(response.bodyBytes);
            allImages.add(file);
          }
        } catch (e) {
          print("❌ Error downloading old image $name: ${e.toString()}");
        }
      }


      for (var image in allImages) {
        if (!await image.exists()) continue;

        final fileName = image.path.split('/').last;
        final multipartFile = await MultipartFile.fromFile(
          image.path,
          filename: fileName,
        );
        formData.files.add(MapEntry('images', multipartFile));
      }

      final response = await dioConsumer.put(
        EndPoint.editmyadd,
        isFromData: true,
        data: formData,
      );

      print(response);
      if (response != null && response.toString().isNotEmpty) {
        try {
          final decryptedText = decrypt(
            response.toString(),
            privateKey,
            publicKey,
          );

          final String jsonData = jsonDecode(decryptedText);
          return Right(jsonData);
        } catch (e) {
          return Left(ServerFailure('🧨 Decryption failed: ${e.toString()}'));
        }
      } else {
        return const Left(ServerFailure('❌ Server returned empty response'));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure('🌐 Network error: ${e.message}'));
      }
      return Left(ServerFailure('🔥 Error: ${e.toString()}'));
    }
  }

}
