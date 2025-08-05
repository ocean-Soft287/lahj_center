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
      id: json['id'],
      name: json['name'],
      eName: json['eName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'eName': eName,
    };
  }
}
