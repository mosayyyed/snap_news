import 'package:dio/dio.dart';
import 'package:news_app/env/env.dart';
import 'package:news_app/models/article_model.dart';

/// A service class for fetching news articles from the News API.
class NewsService {
  final Dio _dio;
  static const _endPoints = 'https://newsapi.org/v2/everything';

  /// Constructor that takes a Dio instance for making HTTP requests.
  NewsService(this._dio);

  /// Fetches breaking news articles.
  Future<List<ArticleModel>> getBreakingNews() async {
    return _fetchNews(query: 'urgent', pageSize: 10, sortBy: 'publishedAt');
  }

  /// Fetches all news articles related to Egypt.
  Future<List<ArticleModel>> getAllNews() async {
    return _fetchNews(query: 'Egypt', sortBy: 'publishedAt');
  }

  /// Fetches news articles related to Gaza.
  Future<List<ArticleModel>> getGazaNews() async {
    return _fetchNews(
        query: 'gaza and (genocide OR resistance)', sortBy: 'publishedAt');
  }

  /// Fetches world news articles.
  Future<List<ArticleModel>> getWorldNews() async {
    return _fetchNews(query: 'world', sortBy: 'publishedAt');
  }

  /// Fetches political news articles.
  Future<List<ArticleModel>> getPoliticsNews() async {
    return _fetchNews(query: 'politics', sortBy: 'publishedAt');
  }

  /// Fetches business news articles.
  Future<List<ArticleModel>> getBusinessNews() async {
    return _fetchNews(query: 'business', sortBy: 'publishedAt');
  }

  /// Fetches tech news articles.
  Future<List<ArticleModel>> getTechNews() async {
    return _fetchNews(query: 'Tech', sortBy: 'publishedAt');
  }

  /// Fetches science news articles.
  Future<List<ArticleModel>> getScienceNews() async {
    return _fetchNews(query: 'science', sortBy: 'publishedAt');
  }

  /// Fetches health news articles.
  Future<List<ArticleModel>> getHealthNews() async {
    return _fetchNews(query: 'health', sortBy: 'publishedAt');
  }

  /// Fetches sports news articles.
  Future<List<ArticleModel>> getSportsNews() async {
    return _fetchNews(query: 'sports', sortBy: 'publishedAt');
  }

  /// Fetches entertainment news articles.
  Future<List<ArticleModel>> getEntertainmentNews() async {
    return _fetchNews(query: 'entertainment', sortBy: 'publishedAt');
  }

  /// Fetches news articles based on the provided query parameters.
  Future<List<ArticleModel>> _fetchNews({
    required String query,
    String sortBy = 'publishedAt',
    String language = 'en',
    int pageSize = 100,
    int page = 1,
  }) async {
    final response = await _dio.get(
      _endPoints,
      queryParameters: {
        'q': query,
        'apiKey': Env.apiKey,
        'sortBy': sortBy,
        'language': language,
        'pageSize': pageSize,
        'page': page,
      },
    );
    return _processResponse(response);
  }

  /// Checks if an article is valid by ensuring it does not contain any invalid values.
  bool isValidArticle(ArticleModel article) {
    const invalidValues = [
      'No Title',
      '[Removed]',
      'No Description',
      'No URL',
      'No Date',
      'No Content'
    ];

    return !invalidValues.contains(article.title) &&
        !invalidValues.contains(article.description) &&
        article.url.isNotEmpty &&
        article.publishedAt.isNotEmpty;
  }

  /// Processes the response from the News API and returns a list of valid articles.
  List<ArticleModel> _processResponse(Response<dynamic> response) {
    final List<dynamic> json = response.data['articles'];
    final List<ArticleModel> articles = json
        .map((dynamic e) => ArticleModel.fromJson(e as Map<String, dynamic>))
        .where(isValidArticle)
        .toList();
    return articles;
  }
}
