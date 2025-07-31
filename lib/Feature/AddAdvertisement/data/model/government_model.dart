import 'package:equatable/equatable.dart';

class Government {
  final int id;
  final String arName;
  final String enName;

  Government({
    required this.id,
    required this.arName,
    required this.enName,
  });

  factory Government.fromJson(Map<String, dynamic> json) {
    return Government(
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