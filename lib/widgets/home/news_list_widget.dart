import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../models/article_model.dart';
import '../../services/news_service.dart';
import 'article_details_sheet_widget.dart';

/// A widget that displays a list of news articles based on a selected category.
///
/// The category is passed as a parameter to the widget.
class NewsList extends StatefulWidget {
  /// The selected category for which to display news articles.
  final String category;

  /// Constructor for the NewsList widget.
  ///
  /// Takes a category as a parameter.
  const NewsList({super.key, required this.category});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  /// A Future that will hold the list of articles to be displayed.
  late Future<List<ArticleModel>> _articlesFuture;

  /// An instance of the NewsService class for fetching news articles.
  final NewsService _newsService = NewsService(Dio());

  @override
  void initState() {
    super.initState();
    _articlesFuture = _fetchArticles();
  }

  @override
  void didUpdateWidget(NewsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.category != oldWidget.category) {
      _articlesFuture = _fetchArticles();
    }
  }

  /// Fetches articles based on the selected category.
  ///
  /// Returns a Future that will hold a list of articles.
  Future<List<ArticleModel>> _fetchArticles() async {
    try {
      List<ArticleModel> articles;
      switch (widget.category) {
        case 'Gaza':
          articles = await _newsService.getGazaNews();
          break;
        case 'World':
          articles = await _newsService.getWorldNews();
          break;
        case 'Politics':
          articles = await _newsService.getPoliticsNews();
          break;
        case 'Business':
          articles = await _newsService.getBusinessNews();
          break;
        case 'Tech':
          articles = await _newsService.getTechNews();
          break;
        case 'Science':
          articles = await _newsService.getScienceNews();
          break;
        case 'Health':
          articles = await _newsService.getHealthNews();
          break;
        case 'Sports':
          articles = await _newsService.getSportsNews();
          break;
        case 'Entertainment':
          articles = await _newsService.getEntertainmentNews();
          break;
        case 'All':
        default:
          articles = await _newsService.getAllNews();
      }
      // Filter articles with valid images
      return articles.where((article) {
        return article.imageUrl.isNotEmpty &&
            Uri.tryParse(article.imageUrl)?.hasAbsolutePath == true;
      }).toList();
    } catch (e) {
      debugPrint(
          "Error fetching articles: $e"); // Use debugPrint for debug logs
      // Consider showing a Snackbar or other user-facing error message
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleModel>>(
      future: _articlesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return SliverFillRemaining(
            child: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SliverFillRemaining(
            child: Center(child: Text('No articles found.')),
          );
        } else {
          final articles = snapshot.data!;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final article = articles[index];
                return _buildArticleTile(context, article);
              },
              childCount: articles.length,
            ),
          );
        }
      },
    );
  }

  /// Builds a tile for a single article.
  ///
  /// Takes the build context and an article as parameters.
  Widget _buildArticleTile(BuildContext context, ArticleModel article) {
    final dateTimeMap =
        article.formattedDateTime; // Use formattedDateTime method
    return GestureDetector(
      onTap: () => showArticleDetails(context, article),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _buildArticleImage(article.imageUrl),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildArticleContent(article, dateTimeMap),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the image for an article tile.
  ///
  /// Takes a URL string as a parameter.
  Widget _buildArticleImage(String? imageUrl) {
    return Container(
      height: 110,
      width: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(23),
        child: CachedNetworkImage(
          imageUrl: imageUrl ?? '',
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Image.asset(
            "assets/placeholder.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  /// Builds the content for an article tile.
  ///
  /// Takes an article and a map of date and time strings as parameters.
  Widget _buildArticleContent(
      ArticleModel article, Map<String, String> dateTimeMap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          article.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        // Conditionally display description if it's not null
        Text(
          article.description,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        _buildArticleDateTimeRow(dateTimeMap),
      ],
    );
  }

  /// Builds a row widget that displays the date and time of an article.
  ///
  /// Takes a map of date and time strings as a parameter.
  Widget _buildArticleDateTimeRow(Map<String, String> dateTimeMap) {
    return Row(
      children: [
        const Icon(Icons.watch_later_outlined, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          dateTimeMap['time'] ?? '',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const Spacer(),
        const Icon(Icons.date_range_rounded, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          dateTimeMap['date'] ?? '',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
