class SubAreaModel {
  final int id;
  final String arName;
  final String enName;
  final int governorateId;
  final String governorateName;
  final String governorateEName;

  SubAreaModel({
    required this.id,
    required this.arName,
    required this.enName,
    required this.governorateId,
    required this.governorateName,
    required this.governorateEName,
  });

  factory SubAreaModel.fromJson(Map<String, dynamic> json) {
    return SubAreaModel(
      id: json['id'] ?? 0,
      arName: json['arName'] ?? '',
      enName: json['enName'] ?? '',
      governorateId: json['governorateId'] ?? 0,
      governorateName: json['governorateName'] ?? '',
      governorateEName: json['governorateEName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'arName': arName,
      'enName': enName,
      'governorateId': governorateId,
      'governorateName': governorateName,
      'governorateEName': governorateEName,
    };
  }
}
