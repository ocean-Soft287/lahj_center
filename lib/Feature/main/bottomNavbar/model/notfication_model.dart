class NotificationModel {
  final int id;
  final String memberId;
  final String deviceToken;
  final String messageBody;
  final bool isSended;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.memberId,
    required this.deviceToken,
    required this.messageBody,
    required this.isSended,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int,
      memberId: json['memberId'] ?? "",
      deviceToken: json['deviceToken'] ?? "",
      messageBody: json['messageBody'] ?? "",
      isSended: json['isSended'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberId': memberId,
      'deviceToken': deviceToken,
      'messageBody': messageBody,
      'isSended': isSended,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
