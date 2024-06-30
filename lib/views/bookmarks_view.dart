import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/drawer/drawer_widget.dart';

class BookmarksView extends StatelessWidget {
  const BookmarksView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: MyDrawer(),
      appBar: CustomAppBar(
        title: "Bookmarks",
      ),
      body: Center(
        child: Text('Bookmarks'),
      ),
    );
  }
}
