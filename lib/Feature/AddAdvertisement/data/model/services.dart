class Services {
  final int id;
  final String name;
  final String eName;

  Services({
    required this.id,
    required this.name,
    required this.eName,
  });

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      id: json['id'] ?? 0,
      name: json['arName'] ?? '',
      eName: json['enName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'arName': name,
      'enName': eName,
    };
  }
}
