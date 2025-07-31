class Item {
  final int id;
  final String name;
  final int groupId;
  final String groupName;
  final String groupEName;
  final int serviceId;
  final String serviceName;
  final String serviceEName;
  final double price;
  final int currencyId;
  final String currencyName;
  final String currencyEName;
  final int governorateId;
  final String governorateName;
  final String governorateEName;
  final String area;
  final String description;
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
    required this.name,
    required this.groupId,
    required this.groupName,
    required this.groupEName,
    required this.serviceId,
    required this.serviceName,
    required this.serviceEName,
    required this.price,
    required this.currencyId,
    required this.currencyName,
    required this.currencyEName,
    required this.governorateId,
    required this.governorateName,
    required this.governorateEName,
    required this.area,
    required this.description,
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
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      groupId: json['groupId'] as int? ?? 0,
      groupName: json['groupName'] as String? ?? '',
      groupEName: json['groupEName'] as String? ?? '',
      serviceId: json['serviceId'] as int? ?? 0,
      serviceName: json['serviceName'] as String? ?? '',
      serviceEName: json['serviceEName'] as String? ?? '',
      price: json['price'] != null ? (json['price'] as num).toDouble() : 0.0,
      currencyId: json['currencyId'] as int? ?? 0,
      currencyName: json['currencyName'] as String? ?? '',
      currencyEName: json['currencyEName'] as String? ?? '',
      governorateId: json['governorateId'] as int? ?? 0,
      governorateName: json['governorateName'] as String? ?? '',
      governorateEName: json['governorateEName'] as String? ?? '',
      area: json['area'] as String? ?? '',
      description: json['description'] as String? ?? '',
      memberId: json['memberId'] as String? ?? '',
      memberName: json['memberName'] as String? ?? '',
      status: json['status'] as String? ?? '',
      deletionReason: json['deletionReason'] as String?  ??"", // nullable
      isCloseReplies: json['isCloseReplies'] as bool? ?? false,
      isLiked: json['isLiked'] as bool? ?? false,
      date: json['date'] != null
          ? DateTime.tryParse(json['date']) ?? DateTime.now()
          : DateTime.now(),
      advertisementImages: (json['advertisementImages'] as List<dynamic>?)
          ?.map((x) => AdvertisementImage.fromJson(x as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}

class AdvertisementImage {
  final int id;
  final String imageName;

  AdvertisementImage({
    required this.id,
    required this.imageName,
  });

  factory AdvertisementImage.fromJson(Map<String, dynamic> json) {
    return AdvertisementImage(
      id: json['id'] as int? ?? 0,
      imageName: json['imageName'] as String? ?? '',
    );
  }
}
