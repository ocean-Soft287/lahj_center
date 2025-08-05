class NewPasswordModel{
  final String message;

  NewPasswordModel({required this.message});

  factory NewPasswordModel.fromJson(Map<String, dynamic> json) {
    return NewPasswordModel(
      message: json['message'],
    );
  }
}