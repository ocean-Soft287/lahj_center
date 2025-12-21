class RegisterResponceModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? imageUrl;
  final String activity;
  final String gender;
  final bool isActive;
  final bool isAdmin;
  final String role;
  final String token;
  final String fullName;
  final DateTime addDate;

  RegisterResponceModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.imageUrl,
    required this.activity,
    required this.gender,
    required this.isActive,
    required this.isAdmin,
    required this.role,
    required this.token,
    required this.fullName,
    required this.addDate,
  });

  /// from json
  factory RegisterResponceModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponceModel(
      id: json['id'] ??"",
      firstName: json['firstName'] ??"",
      lastName: json['lastName'] ??"",
      email: json['email']??"" ,
      phoneNumber: json['phoneNumber'] ??"",
      imageUrl: json['imageUrl'],
      activity: json['activity']??"",
      gender: json['gender'] ??"",
      isActive: json['isActive'] as bool,
      isAdmin: json['isAdmin'] as bool,
      role: json['role'] ??"",
      token: json['token'] ??"",
      fullName: json['fullName'] ??"",
      addDate: DateTime.parse(json['addDate']),
    );
  }

  /// to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'activity': activity,
      'gender': gender,
      'isActive': isActive,
      'isAdmin': isAdmin,
      'role': role,
      'token': token,
      'fullName': fullName,
      'addDate': addDate.toIso8601String(),
    };
  }
}

