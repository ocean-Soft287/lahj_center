class FavouriteResponse {
  final int id;
  final int advertisementId;
  final String memberId;

  FavouriteResponse({
    required this.id,
    required this.advertisementId,
    required this.memberId,
  });

  factory FavouriteResponse.fromJson(Map<String, dynamic> json) {
    return FavouriteResponse(
      id: json['id'] as int,
      advertisementId: json['advertisementId'] as int,
      memberId: json['memberId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'advertisementId': advertisementId,
      'memberId': memberId,
    };
  }
}
