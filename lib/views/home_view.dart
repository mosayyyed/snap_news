import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/drawer/drawer_widget.dart';
import '../widgets/home/breaking_news_list_widget.dart';
import '../widgets/home/categor_selector_widget.dart';
import '../widgets/home/news_list_widget.dart';
import '../widgets/home/search_bar_widget.dart';
import '../widgets/home/section_header_widget.dart';

/// `HomeView` is a stateful widget that represents the home screen of the application.
/// It includes a custom app bar, a drawer, a search bar, and various sections for displaying news.
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

/// `_HomeViewState` is the state object for `HomeView`. It manages the selected category for news.
class _HomeViewState extends State<HomeView> {
  String _selectedCategory = 'All';

  /// `_onTagSelected` is a callback that updates the selected category.
  void _onTagSelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  /// `build` returns the widget tree for the `HomeView`.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: const MyDrawer(),
      appBar: const CustomAppBar(
        title: "Home",
      ),
      body: CustomScrollView(
        slivers: [
          CustomSearchBar(),
          const SectionHeader(title: "Breaking News", seeMore: "See More"),
          const BreakingNewsList(),
          const SectionHeader(title: "Categories", seeMore: "See More"),
          CategorySelector(onTagSelected: _onTagSelected),
          const SectionHeader(title: "Latest News", seeMore: "See More"),
          NewsList(category: _selectedCategory),
        ],
      ),
    );
  }
}
