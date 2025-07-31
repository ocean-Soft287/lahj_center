class BannerModel {
  final String imagePath;
  final String id;


  BannerModel({
    required this.imagePath,
    required this.id,
  });


  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      imagePath: json['ImagePath'] as String,
      id: json['ID'] as String,
    );
  }



}
