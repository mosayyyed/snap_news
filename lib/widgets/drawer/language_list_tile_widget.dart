import 'package:flutter/material.dart';

/// Builds a language list tile widget.
///
/// This widget displays a list tile with a title and an arrow icon.
/// The title and a callback function for the onTap event are passed as parameters to the function.
///
/// The [context] parameter is the build context in which this widget is being constructed.
/// The [title] parameter is the title of the list tile.
/// The [onTap] parameter is a callback function that is called when the list tile is tapped.
///
/// Returns a Padding widget that contains an InkWell widget.
/// The InkWell widget contains a Container widget that displays a row with the title and an arrow icon.
Widget buildeLanguageListTile(BuildContext context, String title,
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
            const Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.grey),
          ],
        ),
      ),
    ),
  );
}
