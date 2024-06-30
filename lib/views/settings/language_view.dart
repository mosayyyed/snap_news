import 'package:flutter/material.dart';
import 'package:news_app/widgets/drawer/drawer_widget.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/drawer/language_list_tile_widget.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: const CustomAppBar(
        title: 'Language',
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: <Widget>[
          buildeLanguageListTile(context, 'English', onTap: () {
            // Change app language to English
          }),
          buildeLanguageListTile(context, 'Spanish', onTap: () {
            // Change app language to Spanish
          }),
          buildeLanguageListTile(context, 'French', onTap: () {
            // Change app language to French
          }),
        ],
      ),
    );
  }
}
