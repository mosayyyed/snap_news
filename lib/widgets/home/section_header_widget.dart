import 'package:flutter/material.dart';

/// A widget that displays a section header with a title and a "See More" text.
///
/// The title and "See More" text are passed as parameters to the widget.
class SectionHeader extends StatelessWidget {
  /// The title of the section.
  final String title;

  /// The "See More" text.
  final String seeMore;

  /// Constructor for the SectionHeader widget.
  ///
  /// Takes a title and a "See More" text as parameters.
  const SectionHeader({
    super.key,
    required this.title,
    required this.seeMore,
  });

  /// Builds the widget.
  ///
  /// Returns a SliverToBoxAdapter widget that contains a Padding widget.
  /// The Padding widget contains a Row widget that displays the title and "See More" text.
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xff08022B),
              ),
            ),
            Text(
              seeMore,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff08022B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
