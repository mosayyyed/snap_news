import 'package:intl/intl.dart';

class ArticleModel {
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String publishedAt;
  final String content;

  ArticleModel({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? 'Unknown Title',
      description: json['description'] ?? 'No Description Available',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
    );
  }

  Map<String, String> get formattedDateTime {
    try {
      final dateTime = DateTime.parse(publishedAt);
      final formattedDate = DateFormat('dd MMM').format(dateTime);
      final formattedTime = DateFormat('hh:mm a').format(dateTime);
      return {'date': formattedDate, 'time': formattedTime};
    } catch (e) {
      return {'date': 'N/A', 'time': 'N/A'};
    }
  }
}
