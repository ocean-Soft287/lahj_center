import 'package:dio/dio.dart';

class UpdateAdvertisementModel {
  final int? id;
  final String? name;
  final String? phone;
  final int? groupId;
  final int? serviceId;
  final int? areaId;
  final int? subGroup;
  final String? condtion;
  final double? price;
  final bool? isCloseReplies;
  final int? currencyId;
  final int? governorateId;
  final String? description;
  final List<String>? imagesToAdd;
  final List<int>? imagesToDelete;

  UpdateAdvertisementModel({
    this.id,
    this.name,
    this.phone,
    this.groupId,
    this.serviceId,
    this.areaId,
    this.subGroup,
    this.condtion,
    this.price,
    this.isCloseReplies,
    this.currencyId,
    this.governorateId,
    this.description,
    this.imagesToAdd,
    this.imagesToDelete,
  });

  FormData toJson() {
    final Map<String, dynamic> data = {};

    if (id != null) data['Id'] = id;
    if (name != null) data['Name'] = name;
    if (phone != null) data['Phone'] = phone;
    if (groupId != null) data['GroupId'] = groupId;
    if (serviceId != null) data['ServiceId'] = serviceId;
    if (areaId != null) data['AreaId'] = areaId;
    if (subGroup != null) data['SubGroupId'] = subGroup;
    if (condtion != null) data['Condition'] = condtion;
    if (price != null) data['Price'] = price;
    if (isCloseReplies != null) data['IsCloseReplies'] = isCloseReplies;
    if (currencyId != null) data['CurrencyId'] = currencyId;
    if (governorateId != null) data['GovernorateId'] = governorateId;
    if (description != null) data['Description'] = description;

    // صور جديدة
    if (imagesToAdd != null && imagesToAdd!.isNotEmpty) {
      data['ImagesToAdd'] = imagesToAdd!
          .map((e) => MultipartFile.fromFileSync(e))
          .toList();
    }

    // حذف الصور: أرسلها كـ ImagesToDelete[0].id
    if (imagesToDelete != null && imagesToDelete!.isNotEmpty) {
      for (int i = 0; i < imagesToDelete!.length; i++) {
        data['ImagesToDelete[$i].id'] = imagesToDelete![i];
      }
    }

    return FormData.fromMap(data);
  }
}
