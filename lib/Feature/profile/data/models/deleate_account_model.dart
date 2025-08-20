class DeleateAccountModel {
  final String message;

  DeleateAccountModel({required this.message});

  factory DeleateAccountModel.fromResponse(dynamic response) {
    if (response is String) {
      // هنا السيرفر بيرجع رسالة نصية زي: "Member is Not Exist"
      return DeleateAccountModel(message: response);
    }
    if (response is Map<String, dynamic>) {
      // لو السيرفر رجع JSON
      return DeleateAccountModel(message: response['message'] ?? 'Success');
    }
    // fallback لو الاستجابة غير متوقعة
    return DeleateAccountModel(message: 'Unexpected response');
  }
}
