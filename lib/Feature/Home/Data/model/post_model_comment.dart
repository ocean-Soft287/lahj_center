
class CommentItem {
  final int id;
  final int advertisementId;
  final String memberId;
  final String comment;
  final DateTime createdAt;
  final String? memberImageUrl;
  final String? memberFullName;

  CommentItem({
    required this.id,
    required this.advertisementId,
    required this.memberId,
    required this.comment,
    required this.createdAt,
    this.memberImageUrl,
    this.memberFullName,
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
