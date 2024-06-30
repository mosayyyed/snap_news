import 'package:flutter/material.dart';

import 'views/Onboarding/onboarding_view.dart';
import 'views/bookmarks_view.dart';
import 'views/explore_view.dart';
import 'views/home_view.dart';
import 'views/profile_view.dart';
import 'views/settings/language_view.dart';
import 'views/settings/privacy_policy_view.dart';
import 'views/settings/settings_view.dart';

/// The main function of the application. It runs the NewsApp.
void main() {
  runApp(const NewsApp());
}

/// NewsApp is a stateless widget that represents the entire application.
/// It sets up the MaterialApp with the necessary theme data and routes.
class NewsApp extends StatelessWidget {
  /// Constructor for NewsApp.
  const NewsApp({super.key});

  /// This method builds the widget and returns a MaterialApp widget.
  /// It sets up the theme data and routes for the application.
  @override
  Widget build(BuildContext context) {
    const Color brandColor = Color(0xFF08022A);

    return MaterialApp(
        title: 'Your App',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(
            seedColor: brandColor, // Use the named constant here.
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const OnboardingView(),
        routes: {
          '/home': (context) => const HomeView(),
          '/bookmarks': (context) => const BookmarksView(),
          '/explore': (context) => const ExploreView(),
          '/profile': (context) => const ProfileView(),
          '/history': (context) => const HomeView(),
          '/language': (context) => const LanguageView(),
          '/dark_mode': (context) => const HomeView(),
          '/live': (context) => const HomeView(),
          '/settings': (context) => const SettingsView(),
          '/privacyPolicyTermsOfService': (context) =>
              const PrivacyPolicyView(),
        });
  }
}
