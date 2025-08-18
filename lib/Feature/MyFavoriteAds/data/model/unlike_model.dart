class UnlikeModel {
  final String message;

  UnlikeModel({required this.message});
factory UnlikeModel.fromJson(Map<String, dynamic> json) {
  return UnlikeModel(
    message: json['message'] ?? '',
  );

}


}

