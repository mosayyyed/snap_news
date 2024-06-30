import 'package:flutter/material.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/drawer/drawer_widget.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: const CustomAppBar(
        title: "Settings",
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: <Widget>[
          buildListTile(context, 'Account Settings', onTap: () {}),
          buildListTile(context, 'Profile', onTap: () {
            Navigator.pushNamed(context, '/profile');
          }),
          buildListTile(context, 'Change Password', onTap: () {
            // Navigate to Change Password Screen
          }),
          buildListTile(context, 'Notification Settings', onTap: () {}),
          _buildSwitchListTile(context, 'Email Notifications',
              value: false, onChanged: (bool value) {}),
          _buildSwitchListTile(context, 'Push Notifications',
              value: true, onChanged: (bool value) {}),
          buildListTile(context, 'Privacy Settings', onTap: () {
            Navigator.pushNamed(context, '/privacyPolicyTermsOfService');
          }),
          _buildSwitchListTile(context, 'Location Access',
              value: true, onChanged: (bool value) {}),
          buildListTile(context, 'Blocked Users', onTap: () {
            // Navigate to Blocked Users Management Screen
          }),
          buildListTile(context, 'General Settings', onTap: () {}),
          buildListTile(context, 'Language', onTap: () {
            // Show language selection dialog
          }),
          _buildSwitchListTile(context, 'Theme',
              value: true, onChanged: (bool value) {}),
          buildListTile(context, 'About', onTap: () {}),
          buildListTile(context, 'Terms of Service', onTap: () {
            Navigator.pushNamed(context, '/termsOfService');
          }),
          buildListTile(context, 'Privacy Policy', onTap: () {
            Navigator.pushNamed(context, '/privacyPolicy');
          }),
          _buildStaticListTile(
              'App Version', '1.0.0'), // Replace with actual app version
        ],
      ),
    );
  }

  Widget buildListTile(BuildContext context, String title,
      {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26.0),
            color: Colors.transparent,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                  size: 16.0, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchListTile(BuildContext context, String title,
      {required bool value, required ValueChanged<bool> onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26.0),
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Switch(
              inactiveThumbColor: const Color(0xFF08022A),
              activeTrackColor: const Color(0xFF08022A),
              value: value,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaticListTile(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26.0),
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
