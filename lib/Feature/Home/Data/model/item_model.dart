class Item {
  final int id;
  final String phone;
  final String name;
  final int groupId;
  final String groupName;
  final String groupEName;
  final int subGroupId;
  final String subGroupName;
  final String subGroupEName;
  final int serviceId;
  final String serviceName;
  final String serviceEName;
  final String condition;
  final double price;
  final int currencyId;
  final String currencyName;
  final String currencyEName;
  final int governorateId;
  final String governorateName;
  final String governorateEName;
  final int areaId;
  final String areaName;
  final String areaEName;
  final String? description;
  final String memberId;
  final String memberName;
  final String status;
  final String? deletionReason;
  final bool isCloseReplies;
  bool isLiked;
  final DateTime date;
  final List<AdvertisementImage> advertisementImages;

  Item({
    required this.id,
    required this.phone,
    required this.name,
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
    this.description,
    required this.memberId,
    required this.memberName,
    required this.status,
    this.deletionReason,
    required this.isCloseReplies,
    this.isLiked = false,
    required this.date,
    required this.advertisementImages,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] ?? 0,
      phone: json['phone'] ?? '',
      name: json['name'] ?? '',
      groupId: json['groupId'] ?? 0,
      groupName: json['groupName'] ?? '',
      groupEName: json['groupEName'] ?? '',
      subGroupId: json['subGroupId'] is int
          ? json['subGroupId']
          : int.tryParse(json['subGroupId'].toString()) ?? 0,
      subGroupName: json['subGroupName'] ?? '',
      subGroupEName: json['subGroupEName'] ?? '',
      serviceId: json['serviceId'] ?? 0,
      serviceName: json['serviceName'] ?? '',
      serviceEName: json['serviceEName'] ?? '',
      condition: json['condition'] ?? '',
      price: json['price'] != null ? (json['price'] as num).toDouble() : 0.0,
      currencyId: json['currencyId'] ?? 0,
      currencyName: json['currencyName'] ?? '',
      currencyEName: json['currencyEName'] ?? '',
      governorateId: json['governorateId'] ?? 0,
      governorateName: json['governorateName'] ?? '',
      governorateEName: json['governorateEName'] ?? '',
      areaId: json['areaId'] ?? 0,
      areaName: json['areaName'] ?? '',
      areaEName: json['areaEName'] ?? '',
      description: json['description'],
      memberId: json['memberId'] ?? '',
      memberName: json['memberName'] ?? '',
      status: json['status'] ?? '',
      deletionReason: json['deletionReason'],
      isCloseReplies: json['isCloseReplies'] ?? false,
      isLiked: json['isLiked'] ?? false,
      date: json['date'] != null
          ? DateTime.tryParse(json['date']) ?? DateTime.now()
          : DateTime.now(),
      advertisementImages: (json['advertisementImages'] as List<dynamic>?)
              ?.map((x) => AdvertisementImage.fromJson(x))
              .toList() ??
          [],
    );
  }
}

class AdvertisementImage {
  final int id;
  final String imageName;

  AdvertisementImage({required this.id, required this.imageName});

  factory AdvertisementImage.fromJson(Map<String, dynamic> json) {
    return AdvertisementImage(
      id: json['id'] ?? 0,
      imageName: json['imageName'] ?? '',
    );
  }
}
