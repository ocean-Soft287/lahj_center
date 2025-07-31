
class CommentModel {
  final List<CommentItem> items;
  final int page;
  final int pageSize;
  final int totalItems;
  final int totalPages;

  CommentModel({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      items: List<CommentItem>.from(json['items'].map((x) => CommentItem.fromJson(x))),
      page: json['page'],
      pageSize: json['pageSize'],
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
    );
  }
}

class CommentItem {
  final int id;
  final int advertisementId;
  final String memberId;
  final String comment;
  final DateTime createdAt;
  final String? memberImageUrl;
  final String memberFullName;

  CommentItem({
    required this.id,
    required this.advertisementId,
    required this.memberId,
    required this.comment,
    required this.createdAt,
    required this.memberImageUrl,
    required this.memberFullName,
  });

  factory CommentItem.fromJson(Map<String, dynamic> json) {
    return CommentItem(
      id: json['id'],
      advertisementId: json['advertisementId'],
      memberId: json['memberId'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
      memberImageUrl: json['memberImageUrl'],
      memberFullName: json['memberFullName'],
    );
  }
}
