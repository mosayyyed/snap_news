import 'package:flutter/material.dart';

/// A widget that allows the user to select a category from a list of predefined categories.
///
/// The selected category is then passed to a callback function.
class CategorySelector extends StatefulWidget {
  /// The callback function to be called when a category is selected.
  ///
  /// This function takes a string (the selected category) as a parameter.
  final Function(String) onTagSelected;

  /// Constructor for the CategorySelector widget.
  ///
  /// Takes a callback function as a parameter.
  const CategorySelector({super.key, required this.onTagSelected});

  /// A list of all available categories.
  static const List<String> allTags = <String>[
    'All',
    'Gaza',
    'World',
    'Politics',
    'Business',
    'Tech',
    'Science',
    'Health',
    'Sports',
    'Entertainment',
  ];

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  /// The index of the currently selected category in the [allTags] list.
  int selectedIndex = 0;

  /// The background color of the selected category tag.
  static const Color selectedTagBackgroundColor = Color(0xff08022B);

  /// The background color of the unselected category tags.
  static const Color unselectedTagBackgroundColor = Colors.grey;

  /// The text color of the selected category tag.
  static const Color selectedTagTextColor = Colors.white;

  /// The text color of the unselected category tags.
  static const Color unselectedTagTextColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: CategorySelector.allTags.length,
            itemBuilder: (context, index) {
              final String tag = CategorySelector.allTags[index];
              final bool isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  // Update state and call callback in one setState call
                  setState(() {
                    selectedIndex = index;
                    widget.onTagSelected(tag);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 2, bottom: 2),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      // Use ternary operator for brevity
                      color: isSelected
                          ? selectedTagBackgroundColor
                          : unselectedTagBackgroundColor.withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                        child: Text(
                          tag,
                          style: TextStyle(
                            // Use ternary operator for brevity
                            color: isSelected
                                ? selectedTagTextColor
                                : unselectedTagTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
