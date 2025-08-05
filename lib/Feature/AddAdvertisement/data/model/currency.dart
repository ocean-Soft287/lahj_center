import 'package:equatable/equatable.dart';

class Currency {
  final int id;
  final String arName;
  final String enName;

  Currency({required this.id, required this.arName, required this.enName});

  // fromJson
  factory Currency.fromJson(Map<String, dynamic> json) {
    print('🔍 Parsing Currency JSON: $json');

    final id = json['id'];
    final arName = json['arName'];
    final enName = json['enName'];

    print(
      '🔍 Currency Parsed Values: id=$id (type: ${id.runtimeType}), arName=$arName, enName=$enName',
    );

    // Handle different id types
    int parsedId;
    if (id == null) {
      parsedId = 0;
    } else if (id is int) {
      parsedId = id;
    } else if (id is String) {
      parsedId = int.tryParse(id) ?? 0;
    } else {
      parsedId = 0;
    }

    print('🔍 Currency Final Parsed ID: $parsedId');

    return Currency(id: parsedId, arName: arName ?? '', enName: enName ?? '');
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {'id': id, 'arName': arName, 'enName': enName};
  }
}
