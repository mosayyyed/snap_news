import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../models/article_model.dart';
import '../../services/news_service.dart';
import 'article_details_sheet_widget.dart';

class BreakingNewsList extends StatefulWidget {
  const BreakingNewsList({super.key});

  @override
  State<BreakingNewsList> createState() => _BreakingNewsListState();
}

class _BreakingNewsListState extends State<BreakingNewsList> {
  List<ArticleModel> breakingNews = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBreakingArticles();
  }

  final NewsService newsService = NewsService(Dio());

  Future<void> _fetchBreakingArticles() async {
    try {
      final fetchedArticles = await newsService.getBreakingNews();
      if (mounted) {
        setState(() {
          // Filter articles directly when assigning to the list
          breakingNews = fetchedArticles.where((article) {
            return article.imageUrl.isNotEmpty &&
                Uri.tryParse(article.imageUrl)?.hasAbsolutePath == true;
          }).toList();
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading news: $e')),
        );
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 220,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: breakingNews.length,
                itemBuilder: (context, index) {
                  final article = breakingNews[index];
                  return _buildNewsArticleCard(article);
                },
              ),
      ),
    );
  }

  Widget _buildNewsArticleCard(ArticleModel article) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: NewsArticleCard(article: article),
    );
  }
}

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
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0x66000000),
                  BlendMode.darken,
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.article.imageUrl,
                  fit: BoxFit.cover,
                  height: 244,
                  width: 244,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Image.asset(
                      "assets/placeholder.jpg",
                      fit: BoxFit.cover,
                      height: 244,
                      width: 244,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: _buildBookmarkButton(),
            ),
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
          _buildArticleDateTimeRow(),
        ],
      ),
    );
  }

  Widget _buildArticleDateTimeRow() {
    final formattedDateTime = article.formattedDateTime;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          formattedDateTime['time'] ?? '',
          style: const TextStyle(fontSize: 12, color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          formattedDateTime['date'] ?? '',
          style: const TextStyle(fontSize: 12, color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
