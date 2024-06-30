import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/article_model.dart';
import '../../services/news_service.dart';
import 'article_details_sheet_widget.dart';

/// A widget that displays a list of breaking news articles.
class BreakingNewsList extends StatefulWidget {
  const BreakingNewsList({super.key});

  @override
  State<BreakingNewsList> createState() => _BreakingNewsListState();
}

class _BreakingNewsListState extends State<BreakingNewsList> {
  List<ArticleModel> topArticles = [];

  @override
  void initState() {
    super.initState();
    _fetchBreakingArticles();
  }

  final newsService = NewsService(Dio());

  /// Fetches breaking news articles and updates the state.
  Future<void> _fetchBreakingArticles() async {
    try {
      final fetchedArticles = await newsService.getBreakingNews();
      if (mounted) {
        setState(() {
          topArticles = fetchedArticles.where((article) {
            return article.urlToImage.isNotEmpty &&
                Uri.tryParse(article.urlToImage)?.hasAbsolutePath == true;
          }).toList();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading news: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: topArticles.length,
          itemBuilder: (context, index) {
            final article = topArticles[index];
            return _buildNewsArticleCard(article);
          },
        ),
      ),
    );
  }

  /// Builds a news article card widget.
  Widget _buildNewsArticleCard(ArticleModel article) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: NewsArticleCard(article: article),
    );
  }
}

/// A widget that displays a news article card.
class NewsArticleCard extends StatefulWidget {
  final ArticleModel article;

  const NewsArticleCard({super.key, required this.article});

  @override
  NewsArticleCardState createState() => NewsArticleCardState();
}

class NewsArticleCardState extends State<NewsArticleCard> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showArticleDetails(context, widget.article),
      child: SizedBox(
        height: 244,
        width: 244,
        child: Stack(
          children: [
            // Background image
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0x66000000),
                  BlendMode.darken,
                ),
                child: Image.network(
                  widget.article.urlToImage,
                  fit: BoxFit.cover,
                  height: 244,
                  width: 244,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
            // Bookmark button
            Positioned(
              top: 8,
              right: 8,
              child: _buildBookmarkButton(),
            ),
            // Article details
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: NewsArticleDetails(article: widget.article),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a bookmark button widget.
  Widget _buildBookmarkButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          setState(() {
            isBookmarked = !isBookmarked;
          });
          // TODO: Implement bookmarking logic here
        },
        child: Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0x88000000),
          ),
          child: Icon(
            isBookmarked
                ? Icons.bookmark_added_rounded
                : Icons.bookmark_add_outlined,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}

/// A widget that displays the details of a news article.
class NewsArticleDetails extends StatelessWidget {
  final ArticleModel article;

  const NewsArticleDetails({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            article.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('dd MMM')
                    .format(DateTime.parse(article.publishedAt)),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              Text(
                DateFormat('HH:mm').format(DateTime.parse(article.publishedAt)),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
