class Services {
  final int id;
  final String arName;
  final String enName;

  Services({
    required this.id,
    required this.arName,
    required this.enName,
  });

  // fromJson
  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      id: json['id'] ?? 0,
      arName: json['arName'] ?? '',
      enName: json['enName'] ?? '',
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'arName': arName,
      'enName': enName,
    };
  }
}