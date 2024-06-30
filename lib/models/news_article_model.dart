class NewsArticleModel {
  final String title;
  final String date;
  final String imageUrl;
  final int views;
  bool isBookmarked = false;

  NewsArticleModel({
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.views,
  });
}
