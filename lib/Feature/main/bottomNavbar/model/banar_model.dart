class BannerSliderModel {
  final String imagePath;
  final num id;

  BannerSliderModel({
    required this.imagePath,
    required this.id,
  });

  factory BannerSliderModel.fromJson(Map<String, dynamic> json) {
    return BannerSliderModel(
      imagePath: json['imageUrl'] ?? "",
      id: json['id'] ?? 0,
    );
  }
}
