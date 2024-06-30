import 'package:flutter/material.dart';

/// A custom AppBar widget.
///
/// This widget displays an AppBar with a title, a menu button, a notifications button, and a user avatar.
/// The title is passed as a parameter to the widget.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title of the AppBar.
  final String title;

  /// Constructor for the CustomAppBar widget.
  ///
  /// Takes a title as a parameter.
  const CustomAppBar({
    required this.title,
    super.key,
  });

  /// Builds the widget.
  ///
  /// Returns an AppBar widget that contains a Row widget.
  /// The Row widget displays the title, a menu button, a notifications button, and a user avatar.
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      forceMaterialTransparency: true,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.menu_rounded,
                        color: Color(0xFF08022A),
                        size: 32,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF08022A),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.notifications_active_rounded,
                  size: 32,
                  color: Color(0xFF08022A),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  radius: 24,
                  backgroundImage: const NetworkImage(
                    'https://avatars.githubusercontent.com/u/113109457?v=4',
                  ),
                  backgroundColor: Colors.grey.shade400,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// Returns the preferred size of the AppBar.
  ///
  /// The preferred size is set to the height of the toolbar.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
