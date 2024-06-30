import 'package:flutter/material.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/drawer/drawer_widget.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: const CustomAppBar(
        title: "Privacy Policy",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          // Use Column instead of ListView inside SingleChildScrollView
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to the start
          children: <Widget>[
            _buildPolicyTitle('1. Your Privacy Matters'),
            _buildPolicyItem(
              'It is our policy to respect your privacy regarding any information we may collect from you across our app, located at [App Name].',
            ),
            _buildPolicyTitle('2. Information We Collect'),
            _buildPolicyItem(
              'We may collect personal information from you when you use our app. This can include information such as your name, email address, and usage data.',
            ),
            _buildPolicyTitle('3. How We Use Information'),
            _buildPolicyItem(
              'We use the information we collect to provide, maintain, and improve our services. This includes using information to support and improve our app’s functionality, communicate with you, and ensure the security of our services.',
            ),
            _buildPolicyTitle('4. Sharing Information'),
            _buildPolicyItem(
              'We do not share your personal information with third parties except as necessary to provide our services, comply with the law, or protect our rights.',
            ),
            _buildPolicyTitle('5. Security'),
            _buildPolicyItem(
              'We take reasonable measures to protect your information from unauthorized access, use, or disclosure. However, please be aware that no method of electronic transmission or storage is 100% secure.',
            ),
            _buildPolicyTitle('6. Changes to This Policy'),
            _buildPolicyItem(
              'We may update our Privacy Policyfrom time to time. We will notify you of any changes by posting the new Privacy Policy on this page.',
            ),
            _buildPolicyTitle('7. Contact Us'),
            _buildPolicyItem(
              'If you have any questions about this Privacy Policy, please contact us.',
            ),
          ],
        ),
      ),
    );
  }

  // Renamed functions for clarity and consistency
  Widget _buildPolicyItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xff08022B),
        ),
      ),
    );
  }

  Widget _buildPolicyTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize:
              20, // Slightly reduced title size for better visual hierarchy
          fontWeight:
              FontWeight.w700, // Adjusted font weight for better readability
          color: Color(0xff08022B),
        ),
      ),
    );
  }
}
