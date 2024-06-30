import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/drawer/drawer_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: MyDrawer(),
      appBar: CustomAppBar(
        title: "Profile",
      ),
      body: Center(
        child: Text('Profile'),
      ),
    );
  }
}
