class ResponseOtpModel {
  final String message;
  final bool canRegister;
  final MemberModel? member;

  ResponseOtpModel({
    required this.message,
    required this.canRegister,
    this.member,
  });

  factory ResponseOtpModel.fromJson(Map<String, dynamic> json) {
    return ResponseOtpModel(
      message: json['message']?.toString() ?? '',
      canRegister: json['canRegister'] ?? false,
      member: json['member'] != null
          ? MemberModel.fromJson(json['member'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'canRegister': canRegister,
      'member': member?.toJson(),
    };
  }
}

class MemberModel {
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
  final String addDate;

  MemberModel({
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

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString(),
      activity: json['activity']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      isActive: json['isActive'] ?? false,
      isAdmin: json['isAdmin'] ?? false,
      role: json['role']?.toString() ?? '',
      token: json['token']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? '',
      addDate: json['addDate']?.toString() ?? '',
    );
  }

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
      'addDate': addDate,
    };
  }
}