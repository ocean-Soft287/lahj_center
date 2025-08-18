class GetAllFavourite {
  final List<FavouriteItem> items;
  final int page;
  final int pageSize;
  final int totalItems;
  final int totalPages;
  //copyWith
  GetAllFavourite copyWith({
    List<FavouriteItem>? items,
    int? page,
    int? pageSize,
    int? totalItems,
    int? totalPages,
  }){
    return GetAllFavourite(
      items: items ?? this.items,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      totalItems: totalItems ?? this.totalItems,
      totalPages: totalPages ?? this.totalPages,
    );
  }
  GetAllFavourite({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });

  factory GetAllFavourite.fromJson(Map<String, dynamic> json) {
    return GetAllFavourite(
      items: (json['items'] as List)
          .map((e) => FavouriteItem.fromJson(e))
          .toList(),
      page: int.tryParse(json['page'].toString()) ?? 0,
      pageSize: int.tryParse(json['pageSize'].toString()) ?? 0,
      totalItems: int.tryParse(json['totalItems'].toString()) ?? 0,
      totalPages: int.tryParse(json['totalPages'].toString()) ?? 0,
    );
  }
}

class FavouriteItem {
  final int id;
  final String name;
  final String phone;
  final int groupId;
  final String groupName;
  final String groupEName;
  final int serviceId;
  final String serviceName;
  final String serviceEName;
  final int price;
  final int currencyId;
  final String currencyName;
  final String currencyEName;
  final int governorateId;
  final String governorateName;
  final String governorateEName;
  final String? area;
  final String? description;
  final String memberId;
  final String memberName;
  final String status;
  final String deletionReason;
  final bool isCloseReplies;
  final bool isLiked;
  final String date;
  final List<dynamic> advertisementImages;

  FavouriteItem({
    required this.id,
    required this.name,
    required this.phone,
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
    this.area,
    this.description,
    required this.memberId,
    required this.memberName,
    required this.status,
    required this.deletionReason,
    required this.isCloseReplies,
    required this.isLiked,
    required this.date,
    required this.advertisementImages,
  });


  //copyWith
  FavouriteItem copyWith({
    int? id,
    String? name,
    String? phone,
    int? groupId,
    String? groupName,
    String? groupEName,
    int? serviceId,
    String? serviceName,
    String? serviceEName,
    int? price,
    int? currencyId,
    String? currencyName,
    String? currencyEName,
    int? governorateId,
    String? governorateName,
    String? governorateEName,
    String? area,
    String? description,
    String? memberId,
    String? memberName,
    String? status,
    String? deletionReason,
    bool? isCloseReplies,
    bool? isLiked,
    String? date,
    List<dynamic>? advertisementImages,
  }) {
   return FavouriteItem(
     id: id ?? this.id,
     name: name ?? this.name,
     phone: phone ?? this.phone,
     groupId: groupId ?? this.groupId,
     groupName: groupName ?? this.groupName,
     groupEName: groupEName ?? this.groupEName,
     serviceId: serviceId ?? this.serviceId,
     serviceName: serviceName ?? this.serviceName,
     serviceEName: serviceEName ?? this.serviceEName,
     price: price ?? this.price,
     currencyId: currencyId ?? this.currencyId,
     currencyName: currencyName ?? this.currencyName,
     currencyEName: currencyEName ?? this.currencyEName,
     governorateId: governorateId ?? this.governorateId,
     governorateName: governorateName ?? this.governorateName,
     governorateEName: governorateEName ?? this.governorateEName,
     area: area ?? this.area,
     description: description ?? this.description,
     memberId: memberId ?? this.memberId,
     memberName: memberName ?? this.memberName,
     status: status ?? this.status,
     deletionReason: deletionReason ?? this.deletionReason,
     isCloseReplies: isCloseReplies ?? this.isCloseReplies,
     isLiked: isLiked ?? this.isLiked,
     date: date ?? this.date,
     advertisementImages: advertisementImages ?? this.advertisementImages,
   );
  }

  factory FavouriteItem.fromJson(Map<String, dynamic> json) {
    return FavouriteItem(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      groupId: int.tryParse(json['groupId'].toString()) ?? 0,
      groupName: json['groupName'] ?? '',
      groupEName: json['groupEName'] ?? '',
      serviceId: int.tryParse(json['serviceId'].toString()) ?? 0,
      serviceName: json['serviceName'] ?? '',
      serviceEName: json['serviceEName'] ?? '',
      price: int.tryParse(json['price'].toString()) ?? 0,
      currencyId: int.tryParse(json['currencyId'].toString()) ?? 0,
      currencyName: json['currencyName'] ?? '',
      currencyEName: json['currencyEName'] ?? '',
      governorateId: int.tryParse(json['governorateId'].toString()) ?? 0,
      governorateName: json['governorateName'] ?? '',
      governorateEName: json['governorateEName'] ?? '',
      area: json['area'],
      description: json['description'],
      memberId: json['memberId'] ?? '',
      memberName: json['memberName'] ?? '',
      status: json['status'] ?? '',
      deletionReason: json['deletionReason'] ?? '',
      isCloseReplies: json['isCloseReplies'] ?? false,
      isLiked: json['isLiked'] ?? false,
      date: json['date'] ?? '',
      advertisementImages: json['advertisementImages'] ?? [],
    );
  }
}
