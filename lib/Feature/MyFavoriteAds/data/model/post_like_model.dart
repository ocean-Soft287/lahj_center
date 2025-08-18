import 'dart:typed_data';

class PostLikeModel {
  final int id;
  
  final Int16List advertisementId;
  final String memberId;
  PostLikeModel({
    required this.id,
    required this.advertisementId,
    required this.memberId,
  });
  factory PostLikeModel.fromJson(Map<String, dynamic> json) {
    return PostLikeModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      advertisementId: json['advertisementId'] ?? '',
      memberId: json['memberId'] ?? '',
    );
  }


}
