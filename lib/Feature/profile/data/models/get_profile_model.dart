class GetProfileModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final String? imageUrl;
  final String? activity;
  final bool isActive;
  final bool isAdmin;
  final String role;
  final String token;
  final String fullName;
  final DateTime addDate;

  GetProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    this.imageUrl,
    this.activity,
    required this.isActive,
    required this.isAdmin,
    required this.role,
    required this.token,
    required this.fullName,
    required this.addDate,
  });

  factory GetProfileModel.fromJson(Map<String, dynamic> json) {
    return GetProfileModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      imageUrl: json['imageUrl'],
      activity: json['activity'],
      isActive: json['isActive'],
      isAdmin: json['isAdmin'],
      role: json['role'],
      token: json['token'],
      fullName: json['fullName'],
      addDate: DateTime.parse(json['addDate']),
    );
  }
}
