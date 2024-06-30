import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/drawer/drawer_widget.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: MyDrawer(),
      appBar: CustomAppBar(
        title: "Explore",
      ),
      body: Center(
        child: Text('Explore'),
      ),
    );
  }
}
