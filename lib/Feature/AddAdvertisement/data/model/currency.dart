import 'package:equatable/equatable.dart';

class Currency {
  final int id;
  final String arName;
  final String enName;

  Currency({
    required this.id,
    required this.arName,
    required this.enName,
  });

  // fromJson
  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id']??"0",
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