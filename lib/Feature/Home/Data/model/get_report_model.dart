class GetReportModel {
  final int? id;
  final int? advertCommentId;
  final String? comment;
  final String? commenterMemberId;
  final String? commenterMemberName;
  final String? reporterMemberId;
  final String? reporterMemberName;
  final String? reason;
  final String? status;

  GetReportModel({
    this.id,
    this.advertCommentId,
    this.comment,
    this.commenterMemberId,
    this.commenterMemberName,
    this.reporterMemberId,
    this.reporterMemberName,
    this.reason,
    this.status,
  });

  factory GetReportModel.fromJson(Map<String, dynamic> json) {
    return GetReportModel(
      id: json['id'],
      advertCommentId: json['advertCommentId'],
      comment: json['comment'],
      commenterMemberId: json['commenterMemberId'],
      commenterMemberName: json['commenterMemberName'],
      reporterMemberId: json['reporterMemberId'],
      reporterMemberName: json['reporterMemberName'],
      reason: json['reason'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'advertCommentId': advertCommentId,
      'comment': comment,
      'commenterMemberId': commenterMemberId,
      'commenterMemberName': commenterMemberName,
      'reporterMemberId': reporterMemberId,
      'reporterMemberName': reporterMemberName,
      'reason': reason,
      'status': status,
    };
  }
}
