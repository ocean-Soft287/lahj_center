class SubGroupModel {
  final int id;
  final String arName;
  final String enName;
  final int groupId;
  final String groupName;
  final String groupEName;

  SubGroupModel({
    required this.id,
    required this.arName,
    required this.enName,
    required this.groupId,
    required this.groupName,
    required this.groupEName,
  });

  factory SubGroupModel.fromJson(Map<String, dynamic> json) {
    return SubGroupModel(
      id: json['id']??0,
      arName: json['arName']??'',
      enName: json['enName']??'',
      groupId: json['groupId']??0,
      groupName: json['groupName']??'',
      groupEName: json['groupEName']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'arName': arName,
      'enName': enName,
      'groupId': groupId,
      'groupName': groupName,
      'groupEName': groupEName,
    };
  }
}
