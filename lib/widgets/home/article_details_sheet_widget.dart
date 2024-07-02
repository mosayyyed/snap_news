import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/article_model.dart';

/// Formats the date and time of the article.
///
/// Takes a string representation of a date and returns a map with the formatted date and time.
/// If the date string is invalid, it returns 'Invalid Date' and 'Invalid Time'.
Map<String, String> formatArticleDateTime(String dateString) {
  try {
    final dateTime = DateTime.parse(dateString);
    final formattedDate = DateFormat('dd MMM').format(dateTime);
    final formattedTime = DateFormat('hh:mm a').format(dateTime);
    return {'date': formattedDate, 'time': formattedTime};
  } catch (e) {
    return {'date': 'Invalid Date', 'time': 'Invalid Time'};
  }
}

/// Displays the details of an article in a modal bottom sheet.
///
/// Takes the build context and an article model as parameters.
void showArticleDetails(BuildContext context, ArticleModel article) {
  ValueNotifier<bool> isBookmarkedNotifier = ValueNotifier<bool>(false);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Stack(
          children: [
            // Background Image
            if (article.urlToImage.isNotEmpty &&
                Uri.tryParse(article.urlToImage)?.hasAbsolutePath == true)
              Hero(
                tag: article.urlToImage,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(36)),
                  child: Image.network(
                    article.urlToImage,
                    fit: BoxFit.cover,
                    height: 330,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.white,
                          size: 100,
                        ),
                      );
                    },
                  ),
                ),
              ),
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0x88000000),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.share_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                  onPressed: () {
                    Share.share('Check out this article: ${article.url}');
                  },
                ),
              ),
            ),
            Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
              ),
              margin: const EdgeInsets.only(top: 300),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.watch_later_outlined,
                            size: 22,
                            color: Color(0xff08022B),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            formatArticleDateTime(article.publishedAt)['time']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff08022B)),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.date_range_rounded,
                            size: 22,
                            color: Color(0xff08022B),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            formatArticleDateTime(article.publishedAt)['date']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff08022B)),
                          ),
                          const Spacer(),
                          ValueListenableBuilder(
                            valueListenable: isBookmarkedNotifier,
                            builder: (context, value, child) {
                              return IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  value
                                      ? Icons.bookmark_added_rounded
                                      : Icons.bookmark_add_outlined,
                                  color: const Color(0xff08022B),
                                  size: 22,
                                ),
                                onPressed: () {
                                  isBookmarkedNotifier.value = !value;
                                },
                              );
                            },
                          ),
                          const Spacer(),
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.launch_rounded,
                              color: Color(0xff08022B),
                              size: 22,
                            ),
                            onPressed: () {
                              launchUrl(Uri.parse(article.url));
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        article.title,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Color(0xff08022B)),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        article.description,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff08022B)),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        article.content,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff08022B)),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          launchUrl(Uri.parse(article.url));
                        },
                        icon: const Icon(Icons.launch, color: Colors.white),
                        label: const Text('Read More',
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(const Color(0xff08022B)),
                          minimumSize: WidgetStateProperty.all(
                              const Size(double.infinity, 50)),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}
