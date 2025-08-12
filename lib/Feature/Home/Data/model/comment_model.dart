
import 'package:lahijcenter/Feature/Home/Data/model/post_model_comment.dart';

class CommentModel {
  final List<CommentItem> items;
  final int page;
  final int pageSize;
  final int totalItems;
  final int totalPages;

  CommentModel({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      items: List<CommentItem>.from(json['items'].map((x) => CommentItem.fromJson(x))),
      page: json['page'],
      pageSize: json['pageSize'],
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
    );
  }
}