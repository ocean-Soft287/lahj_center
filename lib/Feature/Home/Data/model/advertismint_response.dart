import 'item_model.dart';

import 'item_model.dart';

class AdvertisementResponse {
  late final List<Item> items;
  final int page;
  final int pageSize;
  final int totalItems;
  final int totalPages;

  AdvertisementResponse({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });

  factory AdvertisementResponse.fromJson(Map<String, dynamic> json) {
    return AdvertisementResponse(
      items: List<Item>.from(json['items'].map((x) => Item.fromJson(x))),
      page: json['page'],
      pageSize: json['pageSize'],
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
    );
  }
}