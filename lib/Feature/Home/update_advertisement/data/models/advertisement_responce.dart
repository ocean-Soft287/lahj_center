
class AdvertisementResponseModel {
  int id;
  String name;
  String phone;
  int groupId;
  String groupName;
  String groupEName;
  int subGroupId;
  String subGroupName;
  String subGroupEName;
  int serviceId;
  String serviceName;
  String serviceEName;
  String condition;
  double price;
  int currencyId;
  String currencyName;
  String currencyEName;
  int governorateId;
  String governorateName;
  String governorateEName;
  int areaId;
  String areaName;
  String areaEName;
  String description;
  String memberId;
  String memberName;
  String status;
  String deletionReason;
  bool isCloseReplies;
  bool isLiked;
  DateTime date;
  List<AdvertisementImage> advertisementImages;

  AdvertisementResponseModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.groupId,
    required this.groupName,
    required this.groupEName,
    required this.subGroupId,
    required this.subGroupName,
    required this.subGroupEName,
    required this.serviceId,
    required this.serviceName,
    required this.serviceEName,
    required this.condition,
    required this.price,
    required this.currencyId,
    required this.currencyName,
    required this.currencyEName,
    required this.governorateId,
    required this.governorateName,
    required this.governorateEName,
    required this.areaId,
    required this.areaName,
    required this.areaEName,
    required this.description,
    required this.memberId,
    required this.memberName,
    required this.status,
    required this.deletionReason,
    required this.isCloseReplies,
    required this.isLiked,
    required this.date,
    required this.advertisementImages,
  });

  factory AdvertisementResponseModel.fromJson(Map<String, dynamic> json) {
    return AdvertisementResponseModel(
      id: json['id']??0,
      name: json['name']??'',
      phone: json['phone']??'',
      groupId: json['groupId']??0,
      groupName: json['groupName']??'',
      groupEName: json['groupEName']??'',
      subGroupId: json['subGroupId']??0,
      subGroupName: json['subGroupName']??'',
      subGroupEName: json['subGroupEName']??'',
      serviceId: json['serviceId']??0,
      serviceName: json['serviceName']??'',
      serviceEName: json['serviceEName']??'',
      condition: json['condition']??'',
      price: (json['price'] as num).toDouble(),
      currencyId: json['currencyId']??0,
      currencyName: json['currencyName']??'',
      currencyEName: json['currencyEName']??'',
      governorateId: json['governorateId']??0,
      governorateName: json['governorateName']??'',
      governorateEName: json['governorateEName']??'',
      areaId: json['areaId']??0,
      areaName: json['areaName']??'',
      areaEName: json['areaEName']??'',
      description: json['description']??'',
      memberId: json['memberId']??'',
      memberName: json['memberName']??'',
      status: json['status']??'',
      deletionReason: json['deletionReason']??'',
      isCloseReplies: json['isCloseReplies']??false,
      isLiked: json['isLiked']??false,
      date: DateTime.parse(json['date']),
      advertisementImages: (json['advertisementImages'] as List)
          .map((e) => AdvertisementImage.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'groupId': groupId,
      'groupName': groupName,
      'groupEName': groupEName,
      'subGroupId': subGroupId,
      'subGroupName': subGroupName,
      'subGroupEName': subGroupEName,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'serviceEName': serviceEName,
      'condition': condition,
      'price': price,
      'currencyId': currencyId,
      'currencyName': currencyName,
      'currencyEName': currencyEName,
      'governorateId': governorateId,
      'governorateName': governorateName,
      'governorateEName': governorateEName,
      'areaId': areaId,
      'areaName': areaName,
      'areaEName': areaEName,
      'description': description,
      'memberId': memberId,
      'memberName': memberName,
      'status': status,
      'deletionReason': deletionReason,
      'isCloseReplies': isCloseReplies,
      'isLiked': isLiked,
      'date': date.toIso8601String(),
      'advertisementImages':
          advertisementImages.map((e) => e.toJson()).toList(),
    };
  }
}

class AdvertisementImage {
  int id;
  String imageName;

  AdvertisementImage({required this.id, required this.imageName});

  factory AdvertisementImage.fromJson(Map<String, dynamic> json) {
    return AdvertisementImage(
      id: json['id'],
      imageName: json['imageName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageName': imageName,
    };
  }
}
