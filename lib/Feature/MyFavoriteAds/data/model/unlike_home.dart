class UnlikeHome {
  final String message;

  UnlikeHome({
    required this.message,
  });

  factory UnlikeHome.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return UnlikeHome(
        message: json['message']?.toString() ?? '',
      );
    } else if (json is String) {
      return UnlikeHome(
        message: json,
      );
    } else {
      return UnlikeHome(message: '');
    }
  }
}
