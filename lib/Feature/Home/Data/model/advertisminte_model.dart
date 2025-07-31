import 'package:equatable/equatable.dart';

class Service extends Equatable {
  final int id;
  final String arName;
  final String enName;
  final int groupId;

  const Service({
    required this.id,
    required this.arName,
    required this.enName,
    required this.groupId,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['Id'],
      arName: json['ArName'],
      enName: json['EnName'],
      groupId: json['GroupId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'ArName': arName,
      'EnName': enName,
      'GroupId': groupId,
    };
  }

  @override
  List<Object> get props => [id, arName, enName, groupId];
}