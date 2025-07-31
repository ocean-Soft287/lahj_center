class Group {
  final int id;
  final String arName;
  final String enName;

  Group({
    required this.id,
    required this.arName,
    required this.enName,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      arName: json['arName'],
      enName: json['enName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'arName': arName,
      'enName': enName,
    };
  }
}