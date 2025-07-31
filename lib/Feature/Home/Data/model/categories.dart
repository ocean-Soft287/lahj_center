
import 'package:equatable/equatable.dart';

class Categorygroups extends Equatable {
  final int id;
  final String arName;
  final String enName;

  const Categorygroups({required this.id, required this.arName, required this.enName});

  factory Categorygroups.fromJson(Map<String, dynamic> json) {
    return Categorygroups(
      id: json['id'] ?? 0, // لو null يرجعه 0
      arName: json['arName'] ?? 'الكل',
      enName: json['enName'] ?? 'All',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'arName': arName,
      'enName': enName,
    };
  }

  @override
  List<Object> get props => [id, arName, enName];
}