import 'package:equatable/equatable.dart';

class Government {
  final int id;
  final String arName;
  final String enName;

  Government({required this.id, required this.arName, required this.enName});

  factory Government.fromJson(Map<String, dynamic> json) {

    final id = json['id'];
    final arName = json['arName'];
    final enName = json['enName'];




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


    return Government(id: parsedId, arName: arName ?? '', enName: enName ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'arName': arName, 'enName': enName};
  }
}
