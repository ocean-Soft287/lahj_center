class ResponceOtpModel {
  final String message;
  final bool canRegister;
  final String? token;

  ResponceOtpModel({
    required this.message,
    required this.canRegister,
    this.token,
  });

  factory ResponceOtpModel.fromJson(Map<String, dynamic> json) {
    return ResponceOtpModel(
      message: json['message']?.toString() ?? '', // null-safe
      canRegister: json['canRegister'] ?? false, // افتراضي false لو null
      token: json['token']?.toString(), // null-safe
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'canRegister': canRegister,
      'token': token,
    };
  }
}
