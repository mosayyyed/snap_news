import 'package:flutter/material.dart';

/// A model class for a drawer item.
///
/// Each drawer item has an icon, a title, an index, and a color.
class DrawerItemModel {
  /// The icon of the drawer item.
  final IconData icon;

  /// The title of the drawer item.
  final String title;

  /// The index of the drawer item.
  final int index;

  /// The color of the drawer item.
  final Color color;

  /// Constructor for the DrawerItemModel class.
  ///
  /// Takes an icon, a title, an index, and a color as parameters.
  DrawerItemModel({
    required this.icon,
    required this.title,
    required this.index,
    required this.color,
  });
}

/// A custom drawer widget.
///
/// This widget displays a drawer with a list of items.
class MyDrawer extends StatefulWidget {
  /// Constructor for the MyDrawer widget.
  const MyDrawer({super.key});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  /// The index of the currently selected drawer item.
  int _selectedIndex = 0;

  /// A list of routes for the drawer items.
  final List<String> _drawerItemRoutes = [
    '/home',
    '/bookmarks',
    '/history',
    '/language',
    '/dark_mode',
    '/live',
    '/settings',
  ];

  /// Handles the tap event on a drawer item.
  ///
  /// Updates the selected index and navigates to the route of the selected item.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushNamed(context, _drawerItemRoutes[index]);
  }

  /// A list of drawer items.
  final List<DrawerItemModel> _drawerItems = [
    DrawerItemModel(
        icon: Icons.live_tv_rounded,
        title: 'Your Channels',
        index: 0,
        color: const Color(0xFF08022A)),
    DrawerItemModel(
        icon: Icons.bookmark_rounded,
        title: 'Bookmarks',
        index: 1,
        color: const Color(0xFF08022A)),
    DrawerItemModel(
        icon: Icons.history_rounded,
        title: 'History',
        index: 2,
        color: const Color(0xFF08022A)),
    DrawerItemModel(
        icon: Icons.translate_rounded,
        title: 'Language',
        index: 3,
        color: const Color(0xFF08022A)),
    DrawerItemModel(
        icon: Icons.dark_mode_rounded,
        title: 'Dark mode',
        index: 4,
        color: const Color(0xFF08022A)),
    DrawerItemModel(
        icon: Icons.broadcast_on_personal_rounded,
        title: 'Live',
        index: 5,
        color: const Color(0xFF08022A)),
    DrawerItemModel(
        icon: Icons.settings_rounded,
        title: 'Settings',
        index: 6,
        color: const Color(0xFF08022A)),
  ];

  /// Builds a drawer item.
  ///
  /// Takes a DrawerItemModel object as a parameter.
  Widget _buildDrawerItem(DrawerItemModel item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: InkWell(
        onTap: () => _onItemTapped(item.index),
        borderRadius: BorderRadius.circular(36.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26.0),
            color: _selectedIndex == item.index
                ? Colors.blue.withOpacity(0.2)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              Icon(item.icon, color: item.color, size: 28.0),
              const SizedBox(width: 20.0),
              Expanded(
                child: Text(item.title,
                    style: TextStyle(
                        color: item.color,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the widget.
  ///
  /// Returns a ClipRRect widget that contains a Drawer widget.
  /// The Drawer widget contains a Container widget that displays a list of drawer items.
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(32.0),
        bottomRight: Radius.circular(32.0),
      ),
      child: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32.0),
              bottomRight: Radius.circular(32.0),
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://avatars.githubusercontent.com/u/113109457?v=4'),
                    radius: 24,
                  ),
                  title: const Text('Mohamed Elsayed',
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  subtitle: const Text('mosayyyed@gmail.com',
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12,
                          color: Colors.black54)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/profile');
                  }, // Consider adding functionality here
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: _drawerItems.length,
                    itemBuilder: (context, index) => _buildDrawerItem(
                        _drawerItems[index]), // Using renamed function
                  ),
                ),
                const Divider(),
                ListTile(
                  minTileHeight: 10,
                  title: const Text('Privacy policy - Terms of service',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      textAlign: TextAlign.center),
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/privacyPolicyTermsOfService');
                  }, // Consider adding functionality here
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ElevatedButton(
                    onPressed: () {}, // Consider adding functionality here
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF08022A),
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star_rounded,
                            color: Colors.white, size: 28.0),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Get premium',
                            style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
